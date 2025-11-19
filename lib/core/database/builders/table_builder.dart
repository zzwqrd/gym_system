import 'package:sqflite/sqflite.dart';

import 'column_definition.dart';
import 'column_type.dart';

class TableBuilder {
  final DatabaseExecutor _db;
  final String _tableName;
  final List<ColumnDefinition> _columns = [];
  final List<String> _indexes = [];
  final List<String> _triggers = [];

  TableBuilder(this._db, this._tableName);
  // في TableBuilder class
  TableBuilder addForeignKey(
    String column,
    String referencesTable,
    String referencesColumn, {
    String onDelete = 'CASCADE',
    String onUpdate = 'CASCADE',
  }) {
    // البحث عن العمود وإضافة Foreign Key constraint
    final columnIndex = _columns.indexWhere((col) => col.name == column);
    if (columnIndex != -1) {
      final columnDef = _columns[columnIndex];
      _columns[columnIndex] = ColumnDefinition(
        name: columnDef.name,
        type: columnDef.type,
        isNotNull: columnDef.isNotNull,
        isUnique: columnDef.isUnique,
        defaultValue: columnDef.defaultValue,
        foreignKey:
            'REFERENCES $referencesTable($referencesColumn) ON DELETE $onDelete ON UPDATE $onUpdate',
      );
    }
    return this;
  }
  // ========== COLUMN METHODS ========== //

  TableBuilder addColumn(
    String name,
    ColumnType type, {
    bool isNotNull = false,
    bool isUnique = false,
    String? defaultValue,
    String? foreignKey,
  }) {
    _columns.add(
      ColumnDefinition(
        name: name,
        type: type,
        isNotNull: isNotNull,
        isUnique: isUnique,
        defaultValue: defaultValue,
        foreignKey: foreignKey,
      ),
    );
    return this;
  }

  // أضف هذه الدوال في TableBuilder class
  Future<TableBuilder> createWithChecks() async {
    if (_columns.isEmpty) {
      throw Exception('No columns defined for table $_tableName');
    }

    // إنشاء الجدول
    final columnsSql = _columns.map((col) => col.sqlDefinition).join(', ');
    await _db.execute('CREATE TABLE IF NOT EXISTS $_tableName ($columnsSql)');

    // إنشاء الفهارس
    for (final indexSql in _indexes) {
      await _db.execute(indexSql);
    }

    // إنشاء التريجرز
    for (final triggerSql in _triggers) {
      await _db.execute(triggerSql);
    }

    return this;
  }

  // أو بدلاً من ذلك، يمكنك إضافة دالة للتعامل مع القيود مباشرة في addColumn:
  TableBuilder addColumnWithCheck(
    String name,
    ColumnType type, {
    bool isNotNull = false,
    bool isUnique = false,
    String? defaultValue,
    String? checkConstraint,
  }) {
    _columns.add(
      ColumnDefinition(
        name: name,
        type: type,
        isNotNull: isNotNull,
        isUnique: isUnique,
        defaultValue: defaultValue,
        checkConstraint: checkConstraint,
      ),
    );
    return this;
  }
  // ========== INDEX METHODS ========== //

  TableBuilder addIndex(String columnName, {bool unique = false}) {
    final indexName = 'idx_${_tableName}_$columnName';
    final uniqueClause = unique ? 'UNIQUE' : '';
    _indexes.add(
      'CREATE $uniqueClause INDEX IF NOT EXISTS $indexName ON $_tableName ($columnName)',
    );
    return this;
  }

  TableBuilder addCompositeIndex(
    List<String> columns, {
    bool unique = false,
    String? indexName,
  }) {
    final idxName = indexName ?? 'idx_${_tableName}_${columns.join('_')}';
    final columnsStr = columns.join(', ');
    final uniqueClause = unique ? 'UNIQUE' : '';
    _indexes.add(
      'CREATE $uniqueClause INDEX IF NOT EXISTS $idxName ON $_tableName ($columnsStr)',
    );
    return this;
  }

  // ========== TRIGGER METHODS ========== //

  TableBuilder addTimestampTrigger() {
    _triggers.add('''
      CREATE TRIGGER IF NOT EXISTS update_${_tableName}_timestamp
      AFTER UPDATE ON $_tableName
      FOR EACH ROW
      BEGIN
        UPDATE $_tableName SET updated_at = strftime('%Y-%m-%d %H:%M:%S', 'now', 'localtime')
        WHERE id = NEW.id;
      END;
    ''');
    return this;
  }

  TableBuilder addCustomTrigger(
    String triggerName,
    String timing,
    String body,
  ) {
    _triggers.add('''
      CREATE TRIGGER IF NOT EXISTS $triggerName
      $timing ON $_tableName
      FOR EACH ROW
      BEGIN
        $body
      END;
    ''');
    return this;
  }

  // ========== EXECUTION METHODS ========== //

  Future<void> create({bool ifNotExists = true}) async {
    if (_columns.isEmpty) {
      throw Exception('No columns defined for table $_tableName');
    }

    // Create table
    final ifNotExistsClause = ifNotExists ? 'IF NOT EXISTS' : '';
    final columnsSql = _columns.map((col) => col.sqlDefinition).join(', ');

    await _db.execute(
      'CREATE TABLE $ifNotExistsClause $_tableName ($columnsSql)',
    );

    // Create indexes
    for (final indexSql in _indexes) {
      await _db.execute(indexSql);
    }

    // Create triggers
    for (final triggerSql in _triggers) {
      await _db.execute(triggerSql);
    }
  }

  Future<void> drop({bool ifExists = true}) async {
    // Drop triggers first
    for (final triggerSql in _triggers) {
      final triggerName = _extractTriggerName(triggerSql);
      await _db.execute('DROP TRIGGER IF EXISTS $triggerName');
    }

    // Drop indexes
    for (final indexSql in _indexes) {
      final indexName = _extractIndexName(indexSql);
      await _db.execute('DROP INDEX IF EXISTS $indexName');
    }

    // Drop table
    final ifExistsClause = ifExists ? 'IF EXISTS' : '';
    await _db.execute('DROP TABLE $ifExistsClause $_tableName');
  }

  // ========== UTILITY METHODS ========== //

  List<ColumnDefinition> get columns => List.unmodifiable(_columns);

  List<String> get indexes => List.unmodifiable(_indexes);

  List<String> get triggers => List.unmodifiable(_triggers);

  String _extractIndexName(String indexSql) {
    final parts = indexSql.split(' ');
    return parts[4]; // CREATE [UNIQUE] INDEX IF NOT EXISTS index_name
  }

  String _extractTriggerName(String triggerSql) {
    final parts = triggerSql.split(' ');
    return parts[2]; // CREATE TRIGGER IF NOT EXISTS trigger_name
  }
}
