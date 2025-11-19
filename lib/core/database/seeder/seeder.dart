import 'package:sqflite/sqflite.dart';

/// واجهة مجردة لتعريف الـ Seeders.
/// الـ Seeder هو كلاس مسؤول عن إدخال البيانات الأولية (seed data) إلى قاعدة البيانات.
abstract class Seeder {
  /// اسم الـ Seeder، يستخدم للتعرف عليه.
  String get name;

  /// الدالة التي تحتوي على منطق إدخال البيانات.
  /// يتم تمرير كائن [DatabaseExecutor] لتنفيذ عمليات قاعدة البيانات.
  Future<void> run(DatabaseExecutor db);
}
