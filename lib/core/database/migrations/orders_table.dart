import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import 'migration.dart';

class CreateOrdersTable extends Migration {
  @override
  String get name => '2024_01_01_000007_create_orders_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    // جدول الطلبات
    await TableBuilder(db, 'orders')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn(
          'order_number',
          ColumnType.text,
          isNotNull: true,
          isUnique: true,
        )
        .addColumn('user_id', ColumnType.integer)
        .addColumn('total', ColumnType.real, defaultValue: '0')
        .addColumn('status', ColumnType.text, defaultValue: "'pending'")
        .addColumn(
          'created_at',
          ColumnType.timestamp,
          defaultValue: "CURRENT_TIMESTAMP",
        )
        .addIndex('order_number')
        .create();

    // جدول العناصر
    await TableBuilder(db, 'order_items')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('order_id', ColumnType.integer, isNotNull: true)
        .addColumn('product_name', ColumnType.text, isNotNull: true)
        .addColumn('price', ColumnType.real, defaultValue: '0')
        .addColumn('qty', ColumnType.integer, defaultValue: '1')
        .addIndex('order_id')
        .create();
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await TableBuilder(db, 'order_items').drop();
    await TableBuilder(db, 'orders').drop();
  }
}
