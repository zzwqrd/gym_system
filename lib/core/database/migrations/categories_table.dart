import 'package:sqflite/sqflite.dart';

import '../builders/column_type.dart';
import '../builders/table_builder.dart';
import '../seeder/add_default_categories_seeder.dart';
import 'migration.dart';

class CreateCategoriesTable extends Migration {
  @override
  String get name => '2024_01_01_000005_create_categories_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await TableBuilder(db, 'categories')
        .addColumn('id', ColumnType.primaryKey)
        .addColumn('name', ColumnType.text, isNotNull: true)
        .addColumn('slug', ColumnType.text, isNotNull: true, isUnique: true)
        .addColumn('description', ColumnType.text)
        .addColumn('image', ColumnType.text)
        .addColumn('parent_id', ColumnType.integer)
        .addColumn('sort_order', ColumnType.integer, defaultValue: '0')
        .addColumn('is_active', ColumnType.boolean, defaultValue: '1')
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
        // إضافة فهرس للـ foreign key
        .addIndex('slug')
        .addIndex('parent_id')
        .addIndex('is_active')
        .addIndex('sort_order')
        // إضافة التريجر للتحديث التلقائي
        .addTimestampTrigger()
        // إنشاء الجدول
        .create();

    // إدراج فئات افتراضية
    await AddMassiveCategoriesSeeder().run(db);
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    // التراجع عن السيدر أولاً
    // await AddMassiveCategoriesSeeder().rollback(db);
    // ثم حذف الجدول
    await TableBuilder(db, 'categories').drop();
  }
}
