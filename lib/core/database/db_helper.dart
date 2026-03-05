import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

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

  /// ✅ FIX #2: استخدام مسار موحد - getDatabasesPath
  Future<String> get databasePath async {
    final databasesPath = await getDatabasesPath();
    return join(databasesPath, 'app_database.db');
  }

  /// FIX #2: استخدام نفس المسار من databasePath
  Future<Database> _initDatabase() async {
    try {
      final dbPath = await databasePath;
      developer.log('🔧 Initializing database at: $dbPath', name: 'DBHelper');

      return await openDatabase(
        dbPath,
        version: 2,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onConfigure: _onConfigure,
        onOpen: _onOpen,
      );
    } catch (e) {
      developer.log('❌ Database initialization failed: $e', name: 'DBHelper', level: 2000);
      rethrow;
    }
  }

  Future<void> _onConfigure(Database db) async {
    try {
      await db.rawQuery('PRAGMA foreign_keys = ON');
      developer.log('✅ Foreign keys enabled', name: 'DBHelper');
    } catch (e) {
      developer.log('⚠️ Could not enable foreign keys: $e', name: 'DBHelper');
    }
  }

  Future<void> _onOpen(Database db) async {
    try {
      await db.rawQuery('PRAGMA journal_mode = WAL');
      await db.rawQuery('PRAGMA synchronous = NORMAL');
      await db.rawQuery('PRAGMA cache_size = 10000');
      await db.rawQuery('PRAGMA temp_store = MEMORY');
      developer.log('✅ Database optimizations applied', name: 'DBHelper');
    } catch (e) {
      developer.log('⚠️ Could not apply database optimizations: $e', name: 'DBHelper');
    }
  }

  /// ✅ FIX #1: إضافة Seeders في onCreate
  Future<void> _onCreate(Database db, int version) async {
    try {
      developer.log('🔧 Creating database tables...', name: 'DBHelper');
      final manager = MigrationManager();
      await manager.initializeMigrationsTable(db);
      await manager.runPendingMigrations(db, batch: 1);

      // ✅ FIX #1: إضافة البيانات الأولية (Seeders)
      final seederManager = SeederManager([
        AddDefaultEditorUserSeeder(),
        AddMassiveCategoriesSeeder(),
      ]);
      await seederManager.run(db);

      developer.log('✅ Database created successfully with seed data', name: 'DBHelper');
    } catch (e) {
      developer.log('❌ Database creation failed: $e', name: 'DBHelper', level: 2000);
      rethrow;
    }
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      developer.log('🔄 Upgrading database from v$oldVersion to v$newVersion...', name: 'DBHelper');
      final manager = MigrationManager();
      await manager.runPendingMigrations(db, batch: newVersion);
      
      final seederManager = SeederManager([
        AddDefaultEditorUserSeeder(),
        AddMassiveCategoriesSeeder(),
      ]);
      await seederManager.run(db);
      
      developer.log('✅ Database upgraded successfully', name: 'DBHelper');
    } catch (e) {
      developer.log('❌ Database upgrade failed: $e', name: 'DBHelper', level: 2000);
      rethrow;
    }
  }

  /// ✅ FIX #3: تحويل table() إلى async لتجنب Null Pointer
  Future<QueryBuilder> table(String tableName) async {
    final db = await database;
    return QueryBuilder(db, tableName);
  }

  /// Alternative: للاستخدام المباشر في Transaction (لا يحتاج async)
  QueryBuilder tableWithExecutor(DatabaseExecutor executor, String tableName) {
    return QueryBuilder(executor, tableName);
  }

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

  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    final db = await database;
    return await db.transaction(action);
  }

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
      developer.log('✅ Database closed', name: 'DBHelper');
    }
  }

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