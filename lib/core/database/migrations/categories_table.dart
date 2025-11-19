import 'package:sqflite/sqflite.dart';

import '../seeder/add_default_categories_seeder.dart';
import 'migration.dart';

class CreateCategoriesTable extends Migration {
  @override
  String get name => '2024_01_01_000005_create_categories_table';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await createTable(db, 'categories', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      slug TEXT UNIQUE NOT NULL,
      description TEXT,
      image TEXT,
      parent_id INTEGER,
      sort_order INTEGER DEFAULT 0,
      is_active INTEGER DEFAULT 1,
      created_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      updated_at TEXT DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')),
      FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL
    ''');

    await createIndex(db, 'idx_categories_slug', 'categories', 'slug');
    await createIndex(db, 'idx_categories_parent', 'categories', 'parent_id');
    await createIndex(db, 'idx_categories_active', 'categories', 'is_active');

    // إنشاء trigger لتحديث updated_at
    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS update_categories_timestamp
      AFTER UPDATE ON categories
      BEGIN
        UPDATE categories SET updated_at = strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime') 
        WHERE id = NEW.id;
      END
    ''');

    // إدراج فئات افتراضية
    await AddMassiveCategoriesSeeder().run(db);
    // await insertData(db, 'categories', [
    //   {
    //     'name': 'إلكترونيات',
    //     'slug': 'electronics',
    //     'description': 'أجهزة إلكترونية متنوعة',
    //     'sort_order': 1,
    //     'is_active': 1,
    //   },
    //   {
    //     'name': 'ملابس',
    //     'slug': 'clothing',
    //     'description': 'ملابس رجالية ونسائية',
    //     'sort_order': 2,
    //     'is_active': 1,
    //   },
    //   {
    //     'name': 'كتب',
    //     'slug': 'books',
    //     'description': 'كتب متنوعة',
    //     'sort_order': 3,
    //     'is_active': 1,
    //   },
    // ]);
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await db.execute('DROP TRIGGER IF EXISTS update_categories_timestamp');
    await dropIndex(db, 'idx_categories_slug');
    await dropIndex(db, 'idx_categories_parent');
    await dropIndex(db, 'idx_categories_active');
    await dropTable(db, 'categories');
  }
}
