import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import 'migration.dart';

class CreateInventoryHistoryTable extends Migration {
  @override
  String get name =>
      '2025_07_15_000003_recreate_inventory_history_with_timestamps';

  @override
  Future<void> up(DatabaseExecutor db) async {
    // استخدام TableBuilder للجزء الأساسي
    await TableBuilder(db, 'inventory_history')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('inventory_id', ColumnType.integer, isNotNull: true)
        .addColumn('barcode', ColumnType.text, isNotNull: true)
        .addColumn('name', ColumnType.text, isNotNull: true)
        .addColumn('location', ColumnType.text)
        .addColumn('count', ColumnType.integer, isNotNull: true)
        .addColumn('performed_by', ColumnType.integer, isNotNull: true)
        .addColumn(
          'performed_at',
          ColumnType.timestamp,
          defaultValue: "(strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))",
        )
        .addColumn(
          'created_at',
          ColumnType.timestamp,
          defaultValue: "(strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))",
        )
        .addColumn(
          'updated_at',
          ColumnType.timestamp,
          defaultValue: "(strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime'))",
        )
        .addIndex('inventory_id')
        .addIndex('performed_by')
        .addIndex('barcode')
        .addIndex('performed_at')
        .addTimestampTrigger()
        .create();

    // إضافة الأعمدة ذات القيود CHECK يدوياً
    await db.execute('''
      ALTER TABLE inventory_history ADD COLUMN action TEXT CHECK(action IN ('increment', 'decrement')) NOT NULL
    ''');

    await db.execute('''
      ALTER TABLE inventory_history ADD COLUMN performed_by_type TEXT CHECK(performed_by_type IN ('user', 'admin')) NOT NULL
    ''');
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await TableBuilder(db, 'inventory_history').drop();
  }
}
