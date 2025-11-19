// import 'package:sqflite/sqflite.dart';
//
// import 'migration.dart';
//
// class AddNationalIdToUsers extends Migration {
//   @override
//   String get name => '2025_07_12_000003_add_national_id_to_users';
//
//   @override
//   Future<void> up(DatabaseExecutor db) async {
//     // إضافة العمود الجديد من نوع رقم (INTEGER)
//     await db.execute('ALTER TABLE users ADD COLUMN national_id INTEGER');
//   }
//
//   @override
//   Future<void> down(DatabaseExecutor db) async {
//     // ⚠️ SQLite لا يدعم حذف الأعمدة مباشرة
//     print('⚠️ لا يمكن حذف عمود national_id في SQLite مباشرة.');
//   }
// }
