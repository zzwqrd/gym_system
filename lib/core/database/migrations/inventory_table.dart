import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class CreateInventoryTable extends Migration {
  @override
  String get name => '2025_07_15_000001_create_inventory_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await createTable(db, 'inventory', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      barcode TEXT NOT NULL,
      name TEXT NOT NULL,
      location TEXT,
      count INTEGER DEFAULT 0,
      action TEXT CHECK(action IN ('increment', 'decrement')) DEFAULT 'increment',
      created_by INTEGER NOT NULL,
      created_by_type TEXT CHECK(created_by_type IN ('user', 'admin')) NOT NULL,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))
    ''');

    // Trigger لتحديث updated_at عند التعديل
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS update_inventory_timestamp
      AFTER UPDATE ON inventory
      BEGIN
        UPDATE inventory
        SET updated_at = strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')
        WHERE id = NEW.id;
      END;
    ''');

    await createIndex(db, 'idx_inventory_barcode', 'inventory', 'barcode');
    await createIndex(db, 'idx_inventory_creator', 'inventory', 'created_by');
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await db.execute('DROP TRIGGER IF EXISTS update_inventory_timestamp');
    await dropIndex(db, 'idx_inventory_barcode');
    await dropIndex(db, 'idx_inventory_creator');
    await dropTable(db, 'inventory');
  }
}
