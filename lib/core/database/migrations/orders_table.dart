import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class CreateOrdersTable extends Migration {
  @override
  String get name => '2024_01_01_000007_create_orders_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    // جدول الطلبات
    await createTable(db, 'orders', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      order_number TEXT UNIQUE NOT NULL,
      user_id INTEGER,
      status TEXT DEFAULT 'pending',
      total_amount REAL NOT NULL DEFAULT 0,
      tax_amount REAL DEFAULT 0,
      shipping_amount REAL DEFAULT 0,
      discount_amount REAL DEFAULT 0,
      payment_method TEXT,
      payment_status TEXT DEFAULT 'pending',
      shipping_address TEXT,
      billing_address TEXT,
      notes TEXT,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
    ''');

    // جدول عناصر الطلبات
    await createTable(db, 'order_items', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      order_id INTEGER NOT NULL,
      product_id INTEGER NOT NULL,
      product_name TEXT NOT NULL,
      product_sku TEXT,
      quantity INTEGER NOT NULL DEFAULT 1,
      unit_price REAL NOT NULL DEFAULT 0,
      total_price REAL NOT NULL DEFAULT 0,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
      FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
    ''');

    // الفهارس
    await createIndex(db, 'idx_orders_number', 'orders', 'order_number');
    await createIndex(db, 'idx_orders_user', 'orders', 'user_id');
    await createIndex(db, 'idx_orders_status', 'orders', 'status');
    await createIndex(
        db, 'idx_orders_payment_status', 'orders', 'payment_status');

    await createIndex(db, 'idx_order_items_order', 'order_items', 'order_id');
    await createIndex(
        db, 'idx_order_items_product', 'order_items', 'product_id');

    // Triggers
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS update_orders_timestamp
      AFTER UPDATE ON orders
      BEGIN
        UPDATE orders SET updated_at = strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime') 
        WHERE id = NEW.id;
      END
    ''');

    // Trigger لحساب إجمالي الطلب عند إضافة/تعديل عنصر
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS calculate_order_total_insert
      AFTER INSERT ON order_items
      BEGIN
        UPDATE orders 
        SET total_amount = (
          SELECT COALESCE(SUM(total_price), 0) 
          FROM order_items 
          WHERE order_id = NEW.order_id
        ) + tax_amount + shipping_amount - discount_amount
        WHERE id = NEW.order_id;
      END
    ''');

    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS calculate_order_total_update
      AFTER UPDATE ON order_items
      BEGIN
        UPDATE orders 
        SET total_amount = (
          SELECT COALESCE(SUM(total_price), 0) 
          FROM order_items 
          WHERE order_id = NEW.order_id
        ) + tax_amount + shipping_amount - discount_amount
        WHERE id = NEW.order_id;
      END
    ''');

    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS calculate_order_total_delete
      AFTER DELETE ON order_items
      BEGIN
        UPDATE orders 
        SET total_amount = (
          SELECT COALESCE(SUM(total_price), 0) 
          FROM order_items 
          WHERE order_id = OLD.order_id
        ) + tax_amount + shipping_amount - discount_amount
        WHERE id = OLD.order_id;
      END
    ''');
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await db.execute('DROP TRIGGER IF EXISTS update_orders_timestamp');
    await db.execute('DROP TRIGGER IF EXISTS calculate_order_total_insert');
    await db.execute('DROP TRIGGER IF EXISTS calculate_order_total_update');
    await db.execute('DROP TRIGGER IF EXISTS calculate_order_total_delete');

    await dropIndex(db, 'idx_orders_number');
    await dropIndex(db, 'idx_orders_user');
    await dropIndex(db, 'idx_orders_status');
    await dropIndex(db, 'idx_orders_payment_status');
    await dropIndex(db, 'idx_order_items_order');
    await dropIndex(db, 'idx_order_items_product');

    await dropTable(db, 'order_items');
    await dropTable(db, 'orders');
  }
}
