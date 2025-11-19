import 'column_type.dart';

class ColumnDefinition {
  final String name;
  final ColumnType type;
  final bool isNotNull;
  final bool isUnique;
  final String? defaultValue;
  final String? foreignKey;

  ColumnDefinition({
    required this.name,
    required this.type,
    this.isNotNull = false,
    this.isUnique = false,
    this.defaultValue,
    this.foreignKey,
    String? checkConstraint,
  });

  String get sqlDefinition {
    final buffer = StringBuffer();

    buffer.write('$name ');

    // Handle primary key
    if (type == ColumnType.primaryKey) {
      buffer.write('INTEGER PRIMARY KEY AUTOINCREMENT');
    } else {
      buffer.write(type.sqlType);
    }

    // Add constraints
    if (isNotNull) buffer.write(' NOT NULL');
    if (isUnique) buffer.write(' UNIQUE');
    if (defaultValue != null) buffer.write(' DEFAULT $defaultValue');
    if (foreignKey != null) buffer.write(' $foreignKey');

    return buffer.toString().trim();
  }

  @override
  String toString() => sqlDefinition;
}
