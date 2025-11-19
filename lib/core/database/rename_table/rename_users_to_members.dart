import 'package:sqflite/sqflite.dart';

import '../helpers/table_utils.dart'; // ← تأكد من وجود هذا الملف
import '../migrations/migration.dart';

class RenameUsersToMembers extends Migration {
  @override
  String get name => '2025_07_13_000009_rename_users_to_members';

  @override
  Future<void> up(DatabaseExecutor db) async {
    // ✅ طباعة الجداول المرتبطة قبل التسمية
    await TableUtils.printRelatedForeignKeys(
      db: db,
      referencedTable: 'users',
    );

    // ✅ إعادة التسمية
    await TableUtils.renameTableWithForeignKeys(
      db: db,
      oldName: 'users',
      newName: 'members',
    );
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await TableUtils.renameTableWithForeignKeys(
      db: db,
      oldName: 'members',
      newName: 'users',
    );
  }
}
