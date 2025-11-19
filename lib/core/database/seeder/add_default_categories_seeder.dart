import 'package:sqflite/sqflite.dart';

import 'seeder.dart';

class AddMassiveCategoriesSeeder extends Seeder {
  @override
  String get name => 'add_massive_categories_seeder';

  @override
  Future<void> run(DatabaseExecutor db) async {
    const total = 100000;
    const batchSize = 1000;
    final now = DateTime.now().toIso8601String();
    int inserted = 0;

    print('🚀 بدء إضافة $total تصنيف إلى قاعدة البيانات...');

    for (int i = 0; i < total; i += batchSize) {
      final batch = db.batch();

      for (int j = 0; j < batchSize && (i + j) < total; j++) {
        final number = i + j + 1;
        batch.insert(
          'categories',
          {
            'name': 'تصنيف $number',
            'slug': 'category_$number',
            'description': 'وصف للتصنيف رقم $number',
            'sort_order': number,
            'is_active': 1,
            'created_at': now,
            'updated_at': now,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }

      await batch.commit(noResult: true);
      inserted += batchSize;

      print('📦 تم إدخال $inserted / $total تصنيف...');
    }

    print('✅ تم إدخال $total تصنيف إلى جدول التصنيفات بنجاح.');
  }
}

// import 'package:sqflite/sqflite.dart';
//
// import 'seeder.dart';
//
// class AddDefaultCategoriesSeeder extends Seeder {
//   @override
//   String get name => 'add_default_categories_seeder';
//
//   @override
//   Future<void> run(DatabaseExecutor db) async {
//     final now = DateTime.now().toIso8601String();
//
//     final categories = List.generate(40, (index) {
//       final number = index + 1;
//       return {
//         'name': 'تصنيف $number',
//         'slug': 'category_$number',
//         'description': 'وصف للتصنيف رقم $number',
//         'sort_order': number,
//         'is_active': 1,
//         'created_at': now,
//         'updated_at': now,
//       };
//     });
//
//     for (final category in categories) {
//       await db.insert(
//         'categories',
//         category,
//         conflictAlgorithm: ConflictAlgorithm.ignore,
//       );
//     }
//
//     print('✅ تم إدخال 40 تصنيف إلى جدول التصنيفات بنجاح.');
//   }
// }
