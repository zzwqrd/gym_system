import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import 'migration.dart';

class CreateInventoryTable extends Migration {
  @override
  String get name => '2025_07_15_000001_create_inventory_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await TableBuilder(db, 'inventory')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('barcode', ColumnType.text, isNotNull: true)
        .addColumn('name', ColumnType.text, isNotNull: true)
        .addColumn('location', ColumnType.text)
        .addColumn('count', ColumnType.integer, defaultValue: '0')
        .addColumnWithCheck(
          'action',
          ColumnType.text,
          checkConstraint: "IN ('increment', 'decrement')",
          defaultValue: "'increment'",
        )
        .addColumn('created_by', ColumnType.integer, isNotNull: true)
        .addColumnWithCheck(
          'created_by_type',
          ColumnType.text,
          isNotNull: true,
          checkConstraint: "IN ('user', 'admin')",
          defaultValue: "'admin'",
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
        .addIndex('barcode')
        .addIndex('created_by')
        .addIndex('location')
        .addIndex('count')
        .addIndex('action')
        .addTimestampTrigger()
        .createWithChecks();
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await TableBuilder(db, 'inventory').drop();
  }
}
