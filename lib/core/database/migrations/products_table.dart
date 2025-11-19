import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class CreateProductsTable extends Migration {
  @override
  String get name => '2024_01_01_000006_create_products_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await createTable(db, 'products', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      slug TEXT UNIQUE NOT NULL,
      description TEXT,
      short_description TEXT,
      sku TEXT UNIQUE,
      price REAL NOT NULL DEFAULT 0,
      sale_price REAL,
      cost_price REAL,
      stock_quantity INTEGER DEFAULT 0,
      min_stock_level INTEGER DEFAULT 0,
      weight REAL,
      dimensions TEXT,
      category_id INTEGER,
      brand TEXT,
      tags TEXT,
      images TEXT,
      is_active INTEGER DEFAULT 1,
      is_featured INTEGER DEFAULT 0,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
    ''');

    await createIndex(db, 'idx_products_slug', 'products', 'slug');
    await createIndex(db, 'idx_products_sku', 'products', 'sku');
    await createIndex(db, 'idx_products_category', 'products', 'category_id');
    await createIndex(db, 'idx_products_active', 'products', 'is_active');
    await createIndex(db, 'idx_products_featured', 'products', 'is_featured');
    await createIndex(db, 'idx_products_price', 'products', 'price');

    // إنشاء trigger لتحديث updated_at
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS update_products_timestamp
      AFTER UPDATE ON products
      BEGIN
        UPDATE products SET updated_at = strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime') 
        WHERE id = NEW.id;
      END
    ''');
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await db.execute('DROP TRIGGER IF EXISTS update_products_timestamp');
    await dropIndex(db, 'idx_products_slug');
    await dropIndex(db, 'idx_products_sku');
    await dropIndex(db, 'idx_products_category');
    await dropIndex(db, 'idx_products_active');
    await dropIndex(db, 'idx_products_featured');
    await dropIndex(db, 'idx_products_price');
    await dropTable(db, 'products');
  }
}
