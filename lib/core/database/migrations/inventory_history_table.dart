import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class CreateInventoryHistoryTable extends Migration {
  @override
  String get name =>
      '2025_07_15_000003_recreate_inventory_history_with_timestamps';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await db.execute('DROP TABLE IF EXISTS inventory_history');

    await db.execute('''
      CREATE TABLE inventory_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        inventory_id INTEGER NOT NULL,
        barcode TEXT NOT NULL,
        name TEXT NOT NULL,
        location TEXT,
        count INTEGER NOT NULL,
        action TEXT CHECK(action IN ('increment', 'decrement')) NOT NULL,
        performed_by INTEGER NOT NULL,
        performed_by_type TEXT CHECK(performed_by_type IN ('user', 'admin')) NOT NULL,
        performed_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
        created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
        updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
        FOREIGN KEY (inventory_id) REFERENCES inventory(id) ON DELETE CASCADE
      );
    ''');

    await db.execute(
        'CREATE INDEX idx_inventory_history_inventory ON inventory_history(inventory_id)');
    await db.execute(
        'CREATE INDEX idx_inventory_history_actor ON inventory_history(performed_by)');
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await dropIndex(db, 'idx_inventory_history_inventory');
    await dropIndex(db, 'idx_inventory_history_actor');
    await dropTable(db, 'inventory_history');
  }
}
