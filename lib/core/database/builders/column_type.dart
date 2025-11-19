enum ColumnType { primaryKey, integer, text, real, blob, boolean, timestamp }

extension ColumnTypeExtension on ColumnType {
  String get sqlType {
    switch (this) {
      case ColumnType.primaryKey:
        return 'INTEGER PRIMARY KEY AUTOINCREMENT';
      case ColumnType.integer:
        return 'INTEGER';
      case ColumnType.text:
        return 'TEXT';
      case ColumnType.real:
        return 'REAL';
      case ColumnType.blob:
        return 'BLOB';
      case ColumnType.boolean:
        return 'INTEGER'; // SQLite doesn't have boolean
      case ColumnType.timestamp:
        return 'TEXT'; // Store as ISO8601 string
      default:
        return 'TEXT';
    }
  }
}
