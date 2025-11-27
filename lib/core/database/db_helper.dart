import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'migration_manager.dart';
import 'query_builder.dart';
import 'seeder/add_default_categories_seeder.dart';
import 'seeder/add_default_editor_user_seeder.dart';
import 'seeder/seeder_manager.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // ✅ أضف هذا
  Future<String> get databasePath async {
    final databasesPath = await getDatabasesPath();
    return join(
      databasesPath,
      'app_database.db',
    ); // غيّر الاسم حسب اسم قاعدة بياناتك
  }

  Future<Database> _initDatabase() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join(dir.path, 'app_database.db');

      print('🔧 Initializing database at: $path');

      return await openDatabase(
        path,
        version: 10, // تحديث رقم الإصدار حسب الحاجة
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
        onOpen: _onOpen,
      );
    } catch (e) {
      print('❌ Database initialization failed: $e');
      rethrow;
    }
  }

  // يتم تشغيله قبل أي معاملات - آمن للمفاتيح الخارجية
  Future<void> _onConfigure(Database db) async {
    try {
      await db.rawQuery('PRAGMA foreign_keys = ON');
      print('✅ Foreign keys enabled');
    } catch (e) {
      print('⚠️ Could not enable foreign keys: $e');
    }
  }

  // يتم تشغيله بعد فتح قاعدة البيانات - آمن لوضع WAL
  Future<void> _onOpen(Database db) async {
    try {
      await db.rawQuery('PRAGMA journal_mode = WAL');
      await db.rawQuery('PRAGMA synchronous = NORMAL');
      await db.rawQuery('PRAGMA cache_size = 10000');
      await db.rawQuery('PRAGMA temp_store = MEMORY');
      print('✅ Database optimizations applied');
    } catch (e) {
      print('⚠️ Could not apply database optimizations: $e');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      print('🔧 Creating database tables...');
      final manager = MigrationManager();
      await manager.initializeMigrationsTable(db);
      await manager.runPendingMigrations(db, batch: 1);

      print('✅ Database created successfully');
    } catch (e) {
      print('❌ Database creation failed: $e');
      rethrow;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      print('🔄 Upgrading database from v$oldVersion to v$newVersion...');
      final manager = MigrationManager();
      await manager.runPendingMigrations(db, batch: newVersion);
      final seederManager = SeederManager([
        AddDefaultEditorUserSeeder(),
        AddMassiveCategoriesSeeder(),
      ]);
      // ✅ تشغيل Seeders بعد إنشاء الجداول

      // final seederManager = SeederManager(seeders);
      await seederManager.run(db);
      print('✅ Database upgraded successfully');
    } catch (e) {
      print('❌ Database upgrade failed: $e');
      rethrow;
    }
  }

  // Query builder factory method - يدعم DatabaseExecutor
  QueryBuilder table(String tableName) {
    return QueryBuilder(_database!, tableName);
  }

  // إنشاء QueryBuilder للاستخدام مع Transaction
  QueryBuilder tableWithExecutor(DatabaseExecutor executor, String tableName) {
    return QueryBuilder(executor, tableName);
  }

  // Raw query methods
  Future<List<Map<String, dynamic>>> rawQuery(
    String query, [
    List<dynamic>? arguments,
  ]) async {
    final db = await database;
    return await db.rawQuery(query, arguments);
  }

  Future<int> rawInsert(String query, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawInsert(query, arguments);
  }

  Future<int> rawUpdate(String query, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawUpdate(query, arguments);
  }

  Future<int> rawDelete(String query, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawDelete(query, arguments);
  }

  // Transaction support
  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    final db = await database;
    return await db.transaction(action);
  }

  // Batch operations
  Future<List<dynamic>> batch(Function(Batch batch) operations) async {
    final db = await database;
    final batch = db.batch();
    operations(batch);
    return await batch.commit();
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      print('✅ Database closed');
    }
  }

  // Database info methods
  Future<String> getDatabasePath() async {
    final db = await database;
    return db.path;
  }

  Future<int> getDatabaseVersion() async {
    final db = await database;
    final result = await db.rawQuery('PRAGMA user_version');
    return result.first['user_version'] as int;
  }

  Future<List<String>> getTableNames() async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
    );
    return result.map((row) => row['name'] as String).toList();
  }
}
