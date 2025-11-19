import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import 'migration.dart';

class CreateProductsTable extends Migration {
  @override
  String get name => '2024_01_01_000006_create_products_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await TableBuilder(db, 'products')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('name', ColumnType.text, isNotNull: true)
        .addColumn('slug', ColumnType.text, isNotNull: true, isUnique: true)
        .addColumn('description', ColumnType.text)
        .addColumn('short_description', ColumnType.text)
        .addColumn('sku', ColumnType.text, isUnique: true)
        .addColumn('price', ColumnType.real, isNotNull: true, defaultValue: '0')
        .addColumn('sale_price', ColumnType.real)
        .addColumn('cost_price', ColumnType.real)
        .addColumn('stock_quantity', ColumnType.integer, defaultValue: '0')
        .addColumn('min_stock_level', ColumnType.integer, defaultValue: '0')
        .addColumn('weight', ColumnType.real)
        .addColumn('dimensions', ColumnType.text)
        .addColumn('category_id', ColumnType.integer)
        .addColumn('brand', ColumnType.text)
        .addColumn('tags', ColumnType.text)
        .addColumn('images', ColumnType.text)
        .addColumn('is_active', ColumnType.boolean, defaultValue: '1')
        .addColumn('is_featured', ColumnType.boolean, defaultValue: '0')
        .addColumn(
          'created_at',
          ColumnType.timestamp,
          defaultValue: "CURRENT_TIMESTAMP",
        )
        .addColumn(
          'updated_at',
          ColumnType.timestamp,
          defaultValue: "CURRENT_TIMESTAMP",
        )
        .addIndex('slug', unique: true)
        .addIndex('sku', unique: true)
        .addIndex('category_id')
        .addIndex('is_active')
        .addIndex('is_featured')
        .addIndex('price')
        .addIndex('stock_quantity')
        .addIndex('brand')
        .addTimestampTrigger()
        .create();
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await TableBuilder(db, 'products').drop();
  }
}
