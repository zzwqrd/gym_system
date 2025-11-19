import 'package:sqflite/sqflite.dart';

import '../helpers/migration_utils.dart';
import '../migrations/migration.dart';

class RemoveAvatarFromUsers extends Migration {
  @override
  String get name => '2025_07_13_000007_remove_avatar_from_users';

  @override
  Future<void> up(DatabaseExecutor db) async {
    await MigrationUtils.dropColumnPermanently(
      db: db,
      tableName: 'users',
      columnToRemove: 'avatar',
    );

    // ✅ 1. حذف آمن مع احتفاظ بالبيانات:

    // await MigrationUtils.dropColumnSafely(
    //   db: db,
    //   tableName: 'users',
    //   columnToRemove: 'avatar',
    //   columnType: 'TEXT',
    //   primaryKey: 'id',
    // );

    // 🔄 2. استعادة العمود وقيمه:

    //await MigrationUtils.restoreColumnSafely(
    //   db: db,
    //   tableName: 'users',
    //   columnName: 'avatar',
    //   columnType: 'TEXT',
    //   primaryKey: 'id',
    // );

    //❌ 3. حذف نهائي:

    //await MigrationUtils.dropColumnPermanently(
    //   db: db,
    //   tableName: 'users',
    //   columnToRemove: 'avatar',
    // );
  }

  @override
  Future<void> down(DatabaseExecutor db) async {
    await db.execute('ALTER TABLE users ADD COLUMN avatar TEXT;');
  }
}
