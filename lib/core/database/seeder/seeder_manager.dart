import 'package:sqflite/sqflite.dart';

import 'seeder.dart';

final List<dynamic> seeders = [
  // AddDefaultEditorUserSeeder(),
];

class SeederManager {
  final List<Seeder> _seeders;

  SeederManager(this._seeders);

  Future<void> run(Database db) async {
    await _initSeedersTable(db);

    final existingSeeders = await db.query('seeders');
    final existingNames =
        existingSeeders.map((e) => e['name'] as String).toSet();

    for (final seeder in _seeders) {
      if (existingNames.contains(seeder.name)) {
        print('⚠️ Seeder already applied: ${seeder.name}');
        continue;
      }

      print('🚀 Running seeder: ${seeder.name}');
      await db.transaction((txn) async {
        await seeder.run(txn);
        await txn.insert('seeders', {
          'name': seeder.name,
          'ran_at': DateTime.now().toIso8601String(),
        });
      });
      print('✅ Seeder completed: ${seeder.name}');
    }
  }

  Future<void> _initSeedersTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS seeders (
        name TEXT PRIMARY KEY,
        ran_at TEXT
      )
    ''');
  }
}
