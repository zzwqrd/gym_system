import 'package:sqflite/sqflite.dart';

class QueryBuilder {
  final DatabaseExecutor _db;
  final String _table;

  List<String> _columns = ['*'];
  List<WhereClause> _whereClauses = [];
  List<JoinClause> _joinClauses = [];
  List<OrderByClause> _orderByClauses = [];
  List<GroupByClause> _groupByClauses = [];

  String? _havingClause;
  int? _limitValue;
  int? _offsetValue;

  QueryBuilder(this._db, this._table);

  // ========== SELECT CLAUSES ========== //

  QueryBuilder select(List<String> columns) {
    _columns = columns;
    return this;
  }

  QueryBuilder addSelect(List<String> columns) {
    _columns.addAll(columns);
    return this;
  }

  QueryBuilder selectRaw(String rawSelect) {
    _columns = [rawSelect];
    return this;
  }

  // ========== WHERE CLAUSES ========== //

  QueryBuilder where(String column, dynamic value, {String operator = '='}) {
    _whereClauses.add(WhereClause(column, operator, value, 'AND'));
    return this;
  }

  QueryBuilder orWhere(String column, dynamic value, {String operator = '='}) {
    _whereClauses.add(WhereClause(column, operator, value, 'OR'));
    return this;
  }

  QueryBuilder whereIn(String column, List<dynamic> values) {
    _whereClauses.add(WhereClause(column, 'IN', values, 'AND'));
    return this;
  }

  QueryBuilder whereNotIn(String column, List<dynamic> values) {
    _whereClauses.add(WhereClause(column, 'NOT IN', values, 'AND'));
    return this;
  }

  QueryBuilder whereNull(String column) {
    _whereClauses.add(WhereClause(column, 'IS', null, 'AND'));
    return this;
  }

  QueryBuilder whereNotNull(String column) {
    _whereClauses.add(WhereClause(column, 'IS NOT', null, 'AND'));
    return this;
  }

  QueryBuilder whereBetween(String column, dynamic start, dynamic end) {
    _whereClauses.add(WhereClause(column, 'BETWEEN', [start, end], 'AND'));
    return this;
  }

  QueryBuilder whereNotBetween(String column, dynamic start, dynamic end) {
    _whereClauses.add(WhereClause(column, 'NOT BETWEEN', [start, end], 'AND'));
    return this;
  }

  QueryBuilder whereLike(String column, String pattern) {
    _whereClauses.add(WhereClause(column, 'LIKE', pattern, 'AND'));
    return this;
  }

  QueryBuilder whereNotLike(String column, String pattern) {
    _whereClauses.add(WhereClause(column, 'NOT LIKE', pattern, 'AND'));
    return this;
  }

  QueryBuilder whereRaw(String rawWhere, [List<dynamic>? bindings]) {
    _whereClauses.add(WhereClause(
        '', 'RAW', {'query': rawWhere, 'bindings': bindings ?? []}, 'AND'));
    return this;
  }

  QueryBuilder orWhereRaw(String rawWhere, [List<dynamic>? bindings]) {
    _whereClauses.add(WhereClause(
        '', 'RAW', {'query': rawWhere, 'bindings': bindings ?? []}, 'OR'));
    return this;
  }

  // ========== JOIN CLAUSES ========== //

  QueryBuilder join(
      String table, String first, String operator, String second) {
    _joinClauses.add(JoinClause(table, first, operator, second, 'INNER'));
    return this;
  }

  QueryBuilder leftJoin(
      String table, String first, String operator, String second) {
    _joinClauses.add(JoinClause(table, first, operator, second, 'LEFT'));
    return this;
  }

  QueryBuilder rightJoin(
      String table, String first, String operator, String second) {
    _joinClauses.add(JoinClause(table, first, operator, second, 'RIGHT'));
    return this;
  }

  QueryBuilder crossJoin(String table) {
    _joinClauses.add(JoinClause(table, '', '', '', 'CROSS'));
    return this;
  }

  // ========== ORDERING & GROUPING ========== //

  QueryBuilder orderBy(String column, {String direction = 'ASC'}) {
    _orderByClauses.add(OrderByClause(column, direction));
    return this;
  }

  QueryBuilder orderByRaw(String rawOrder) {
    _orderByClauses.add(OrderByClause(rawOrder, ''));
    return this;
  }

  QueryBuilder groupBy(String column) {
    _groupByClauses.add(GroupByClause(column));
    return this;
  }

  QueryBuilder having(String havingClause) {
    _havingClause = havingClause;
    return this;
  }

  QueryBuilder latest([String column = 'created_at']) {
    return orderBy(column, direction: 'DESC');
  }

  QueryBuilder oldest([String column = 'created_at']) {
    return orderBy(column, direction: 'ASC');
  }

  // ========== LIMIT & OFFSET ========== //

  QueryBuilder limit(int limit) {
    _limitValue = limit;
    return this;
  }

  QueryBuilder offset(int offset) {
    _offsetValue = offset;
    return this;
  }

  QueryBuilder take(int count) => limit(count);
  QueryBuilder skip(int count) => offset(count);

  // ========== CHUNKING ========== //
  QueryBuilder clone() {
    final copy = QueryBuilder(_db, _table);
    copy._columns = List.from(_columns);
    copy._whereClauses = List.from(_whereClauses);
    copy._joinClauses = List.from(_joinClauses);
    copy._orderByClauses = List.from(_orderByClauses);
    copy._groupByClauses = List.from(_groupByClauses);
    copy._havingClause = _havingClause;
    copy._limitValue = _limitValue;
    copy._offsetValue = _offsetValue;
    return copy;
  }

  // ========== GroupWhere ========== //
  QueryBuilder groupWhere(void Function(QueryBuilder builder) group,
      {String boolean = 'AND'}) {
    final groupBuilder = QueryBuilder(_db, _table);
    group(groupBuilder);
    final groupClause = groupBuilder._buildWhereClause();

    _whereClauses.add(
      WhereClause(
          '',
          'RAW',
          {
            'query': '(${groupClause.query})',
            'bindings': groupClause.args,
          },
          boolean),
    );

    return this;
  }

  // ========== CRUD OPERATIONS ========== //

  Future<List<Map<String, dynamic>>> get() async {
    try {
      final result = await _runSelectQuery();
      _resetQuery();
      return result;
    } catch (e) {
      _resetQuery();
      print('❌ Query failed: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> first() async {
    final results = await limit(1).get();
    return results.isEmpty ? null : results.first;
  }

  Future<Map<String, dynamic>> firstOrFail() async {
    final result = await first();
    if (result == null) {
      throw Exception('No records found in $_table');
    }
    return result;
  }

  Future<T?> value<T>(String column) async {
    final result = await select([column]).first();
    return result?[column] as T?;
  }

  Future<List<T>> pluck<T>(String column) async {
    final results = await select([column]).get();
    return results.map((row) => row[column] as T).toList();
  }

  Future<int> count([String column = '*']) async {
    try {
      final result =
          await _db.rawQuery(_buildCountQuery(column), _buildWhereArgs());
      _resetQuery();
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      _resetQuery();
      print('❌ Count query failed: $e');
      rethrow;
    }
  }

  Future<double> sum(String column) async {
    try {
      final result = await _db.rawQuery(
          _buildAggregateQuery('SUM', column), _buildWhereArgs());
      _resetQuery();
      return (result.first.values.first as num?)?.toDouble() ?? 0.0;
    } catch (e) {
      _resetQuery();
      rethrow;
    }
  }

  Future<double> avg(String column) async {
    try {
      final result = await _db.rawQuery(
          _buildAggregateQuery('AVG', column), _buildWhereArgs());
      _resetQuery();
      return (result.first.values.first as num?)?.toDouble() ?? 0.0;
    } catch (e) {
      _resetQuery();
      rethrow;
    }
  }

  Future<T?> max<T>(String column) async {
    try {
      final result = await _db.rawQuery(
          _buildAggregateQuery('MAX', column), _buildWhereArgs());
      _resetQuery();
      return result.first.values.first as T?;
    } catch (e) {
      _resetQuery();
      rethrow;
    }
  }

  Future<T?> min<T>(String column) async {
    try {
      final result = await _db.rawQuery(
          _buildAggregateQuery('MIN', column), _buildWhereArgs());
      _resetQuery();
      return result.first.values.first as T?;
    } catch (e) {
      _resetQuery();
      rethrow;
    }
  }

  Future<bool> exists() async {
    final count = await this.count();
    return count > 0;
  }

  Future<bool> doesntExist() async {
    return !(await exists());
  }

  Future<int> insert(Map<String, dynamic> values) async {
    try {
      return await _db.insert(_table, values);
    } catch (e) {
      print('❌ Insert failed: $e');
      rethrow;
    }
  }

  Future<int> insertOrIgnore(Map<String, dynamic> values) async {
    try {
      return await _db.insert(_table, values,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      print('❌ Insert or ignore failed: $e');
      rethrow;
    }
  }

  Future<int> insertOrReplace(Map<String, dynamic> values) async {
    try {
      return await _db.insert(_table, values,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('❌ Insert or replace failed: $e');
      rethrow;
    }
  }

  Future<int> update(Map<String, dynamic> values) async {
    if (_whereClauses.isEmpty) {
      throw Exception('Update queries must have where clauses for safety');
    }

    try {
      final where = _buildWhereClause();
      final result = await _db.update(
        _table,
        values,
        where: where.query,
        whereArgs: where.args,
      );
      _resetQuery();
      return result;
    } catch (e) {
      _resetQuery();
      print('❌ Update failed: $e');
      rethrow;
    }
  }

  Future<int> delete() async {
    if (_whereClauses.isEmpty) {
      throw Exception('Delete queries must have where clauses for safety');
    }

    try {
      final where = _buildWhereClause();
      final result = await _db.delete(
        _table,
        where: where.query,
        whereArgs: where.args,
      );
      _resetQuery();
      return result;
    } catch (e) {
      _resetQuery();
      print('❌ Delete failed: $e');
      rethrow;
    }
  }

  Future<void> truncate() async {
    try {
      await _db.delete(_table);
    } catch (e) {
      print('❌ Truncate failed: $e');
      rethrow;
    }
  }

  // ========== PAGINATION ========== //

  Future<Map<String, dynamic>> paginate(int page, int perPage) async {
    final totalCount = await count();
    final totalPages = (totalCount / perPage).ceil();
    final offset = (page - 1) * perPage;

    final data = await this.offset(offset).limit(perPage).get();

    return {
      'data': data,
      'current_page': page,
      'per_page': perPage,
      'total': totalCount,
      'total_pages': totalPages,
      'has_next_page': page < totalPages,
      'has_prev_page': page > 1,
    };
  }

  // ========== QUERY BUILDING ========== //

  Future<List<Map<String, dynamic>>> _runSelectQuery() async {
    final query = _buildSelectQuery();
    final args = _buildWhereArgs();
    return await _db.rawQuery(query, args);
  }

  String _buildSelectQuery() {
    final query = StringBuffer('SELECT ${_columns.join(', ')} FROM $_table');

    // JOIN CLAUSES
    for (final join in _joinClauses) {
      if (join.type == 'CROSS') {
        query.write(' CROSS JOIN ${join.table}');
      } else {
        query.write(
            ' ${join.type} JOIN ${join.table} ON ${join.first} ${join.operator} ${join.second}');
      }
    }

    // WHERE CLAUSES
    if (_whereClauses.isNotEmpty) {
      query.write(' WHERE ${_buildWhereClause().query}');
    }

    // GROUP BY
    if (_groupByClauses.isNotEmpty) {
      query.write(
          ' GROUP BY ${_groupByClauses.map((g) => g.column).join(', ')}');
    }

    // HAVING
    if (_havingClause != null) {
      query.write(' HAVING $_havingClause');
    }

    // ORDER BY
    if (_orderByClauses.isNotEmpty) {
      query.write(
          ' ORDER BY ${_orderByClauses.map((o) => o.direction.isEmpty ? o.column : '${o.column} ${o.direction}').join(', ')}');
    }

    // LIMIT & OFFSET
    if (_limitValue != null) {
      query.write(' LIMIT $_limitValue');
    }

    if (_offsetValue != null) {
      query.write(' OFFSET $_offsetValue');
    }

    return query.toString();
  }

  String _buildCountQuery([String column = '*']) {
    final query = StringBuffer('SELECT COUNT($column) as count FROM $_table');

    // JOIN CLAUSES
    for (final join in _joinClauses) {
      if (join.type == 'CROSS') {
        query.write(' CROSS JOIN ${join.table}');
      } else {
        query.write(
            ' ${join.type} JOIN ${join.table} ON ${join.first} ${join.operator} ${join.second}');
      }
    }

    if (_whereClauses.isNotEmpty) {
      query.write(' WHERE ${_buildWhereClause().query}');
    }

    return query.toString();
  }

  String _buildAggregateQuery(String function, String column) {
    final query = StringBuffer('SELECT $function($column) FROM $_table');

    if (_whereClauses.isNotEmpty) {
      query.write(' WHERE ${_buildWhereClause().query}');
    }

    return query.toString();
  }

  ({String query, List<dynamic> args}) _buildWhereClause() {
    final query = StringBuffer();
    final args = <dynamic>[];
    var firstCondition = true;

    for (final clause in _whereClauses) {
      if (!firstCondition) {
        query.write(' ${clause.boolean} ');
      } else {
        firstCondition = false;
      }

      switch (clause.operator) {
        case 'IN':
        case 'NOT IN':
          final placeholders = List.filled(clause.value.length, '?').join(', ');
          query.write('${clause.column} ${clause.operator} ($placeholders)');
          args.addAll(clause.value);
          break;

        case 'BETWEEN':
        case 'NOT BETWEEN':
          query.write('${clause.column} ${clause.operator} ? AND ?');
          args.addAll(clause.value);
          break;

        case 'IS':
        case 'IS NOT':
          query.write('${clause.column} ${clause.operator} NULL');
          break;

        case 'RAW':
          final rawData = clause.value as Map<String, dynamic>;
          query.write('(${rawData['query']})');
          args.addAll(rawData['bindings']);
          break;

        default:
          query.write('${clause.column} ${clause.operator} ?');
          args.add(clause.value);
      }
    }

    return (query: query.toString(), args: args);
  }

  List<dynamic> _buildWhereArgs() {
    return _buildWhereClause().args;
  }

  void _resetQuery() {
    _columns = ['*'];
    _whereClauses.clear();
    _joinClauses.clear();
    _orderByClauses.clear();
    _groupByClauses.clear();
    _havingClause = null;
    _limitValue = null;
    _offsetValue = null;
  }

  // ========== DEBUGGING ========== //

  String toSql() {
    final query = _buildSelectQuery();
    final args = _buildWhereArgs();
    return 'Query: $query\nArgs: $args';
  }

  void dd() {
    print(toSql());
  }

  void dump() {
    print('Table: $_table');
    print('Columns: $_columns');
    print('Where Clauses: ${_whereClauses.length}');
    print('Join Clauses: ${_joinClauses.length}');
    print('Order By: ${_orderByClauses.length}');
    print('Limit: $_limitValue');
    print('Offset: $_offsetValue');
  }
}

// ========== HELPER CLASSES ========== //

class WhereClause {
  final String column;
  final String operator;
  final dynamic value;
  final String boolean;

  WhereClause(this.column, this.operator, this.value, this.boolean);
}

class JoinClause {
  final String table;
  final String first;
  final String operator;
  final String second;
  final String type;

  JoinClause(this.table, this.first, this.operator, this.second, this.type);
}

class OrderByClause {
  final String column;
  final String direction;

  OrderByClause(this.column, this.direction);
}

class GroupByClause {
  final String column;

  GroupByClause(this.column);
}
