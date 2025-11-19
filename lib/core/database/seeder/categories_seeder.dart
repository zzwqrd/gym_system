import 'package:sqflite/sqflite.dart';

import 'seeder.dart';

class CategoriesSeeder extends Seeder {
  @override
  String get name => 'categories_seeder';

  @override
  Future<void> run(DatabaseExecutor db) async {
    final now = DateTime.now().toIso8601String();

    final categories = [
      {
        'name': 'إلكترونيات',
        'slug': 'electronics',
        'description': 'أجهزة إلكترونية متنوعة',
        'sort_order': 1,
        'is_active': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'ملابس',
        'slug': 'clothing',
        'description': 'ملابس رجالية ونسائية',
        'sort_order': 2,
        'is_active': 1,
        'created_at': now,
        'updated_at': now,
      },
      {
        'name': 'كتب',
        'slug': 'books',
        'description': 'كتب متنوعة',
        'sort_order': 3,
        'is_active': 1,
        'created_at': now,
        'updated_at': now,
      },
    ];

    for (var category in categories) {
      await db.insert(
        'categories',
        category,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }
}
