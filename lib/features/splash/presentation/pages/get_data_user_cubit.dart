// lib/features/users/presentation/cubit/get_data_user_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/database/db_helper.dart';
import 'user_model.dart';

// الكيوبت المسؤول عن جلب بيانات المستخدمين من قاعدة البيانات بئكثر من طريقة
// لتجربه الاستعلامات المختلفة
@visibleForTesting
class GetDataUserCubit extends Cubit<GetDataUserState> {
  final DBHelper _dbHelper = DBHelper();

  GetDataUserCubit() : super(GetDataUserInitial());

  // جلب كل المستخدمين
  Future<void> getAllUsers() async {
    try {
      emit(GetDataUserLoading());

      final results = await _dbHelper.table('users').get();

      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      if (users.isEmpty) {
        emit(GetDataUserLoaded([]));
        return;
      }
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load users: $e'));
    }
  }

  // جلب مستخدم واحد
  Future<void> getFirstUser() async {
    try {
      emit(GetDataUserLoading());

      final userMap = await _dbHelper.table('users').first();

      if (userMap != null) {
        final user = User.fromMap(userMap);
        emit(GetDataUserLoaded([user]));
      } else {
        emit(GetDataUserError('No users found'));
      }
    } catch (e) {
      emit(GetDataUserError('Failed to load user: $e'));
    }
  }

  // جلب مستخدم بالإيميل
  Future<void> getUserByEmail(String email) async {
    try {
      emit(GetDataUserLoading());

      final userMap = await _dbHelper
          .table('users')
          .where('email', email)
          .first();

      if (userMap != null) {
        final user = User.fromMap(userMap);
        emit(GetDataUserLoaded([user]));
      } else {
        emit(GetDataUserError('User not found'));
      }
    } catch (e) {
      emit(GetDataUserError('Failed to load user: $e'));
    }
  }

  // جلب المستخدمين النشطين فقط
  Future<void> getActiveUsers() async {
    try {
      emit(GetDataUserLoading());

      final results = await _dbHelper
          .table('users')
          .where('is_active', 1)
          .get();

      final users = results.map((userMap) => User.fromMap(userMap)).toList();

      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load active users: $e'));
    }
  }

  // جلب المستخدمين غير النشطين فقط
  Future<void> getInactiveUsers() async {
    try {
      emit(GetDataUserLoading());

      final results = await _dbHelper
          .table('users')
          .where('is_active', 0)
          .get();

      final users = results.map((userMap) => User.fromMap(userMap)).toList();

      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load inactive users: $e'));
    }
  }

  // استخدم orWhere لجلب المستخدمين الغير نشطين
  Future<void> getInactiveOrUnverifiedUsers() async {
    try {
      emit(GetDataUserLoading());
      // اشرحلي لي orWhere استخدمتها
      // orWhere بتسمحلك تضيف شرط اضافي في الاستعلام بحيث لو اي من الشروط اتحقق، السجل هيتم اختياره.
      // في الحالة دي، احنا عايزين نجيب المستخدمين اللي مش نشطين (is_active = 0) او اللي مش موثقين (is_verified = 0).
      // باستخدام orWhere مرتين، بنضمن ان اي مستخدم يحقق اي من الشروط دي هيتم تضمينه في النتيجة.

      final results = await _dbHelper
          .table('users')
          .orWhere('is_active', 1)
          .orWhere('is_verified', 1)
          .orWhere("last_name", "User")
          .get();

      final users = results.map((userMap) => User.fromMap(userMap)).toList();

      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load inactive or unverified users: $e'));
    }
  }

  // whereIn لجلب مستخدمين  الغير نشطين
  Future<void> getInactiveUsersWhereIn() async {
    try {
      emit(GetDataUserLoading());
      final results = await _dbHelper
          .table('users')
          .whereIn('is_active', [
            0,
            2,
          ]) // جلب المستخدمين الغير نشطين (0) او في حالة اخرى (2)
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load inactive users (whereIn): $e'));
    }
  }

  // whereNotIn لجلب مستخدمين نشطين
  Future<void> getActiveUsersWhereNotIn() async {
    try {
      emit(GetDataUserLoading());
      final results = await _dbHelper
          .table('users')
          .whereNotIn('is_active', [0, 2]) // جلب المستخدمين النشطين (مش 0 او 2)
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load active users (whereNotIn): $e'));
    }
  }

  // whereNull لجلب المستخدمين اللي مفيش عندهم صورة
  Future<void> getUsersWithNullAvatar() async {
    try {
      emit(GetDataUserLoading());
      final results = await _dbHelper
          .table('users')
          .whereNull('avatar') // جلب المستخدمين اللي مفيش عندهم صورة
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load users with null avatar: $e'));
    }
  }

  // whereNotNull هات المستخدمين الغير نشطين اللي عندهم صورة
  Future<void> getInactiveUsersWithAvatar() async {
    try {
      emit(GetDataUserLoading());
      final results = await _dbHelper
          .table('users')
          .where('is_active', 0) // مستخدمين غير نشطين
          .whereNotNull('avatar') // وعندهم صورة
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load inactive users with avatar: $e'));
    }
  }

  // whereNull و whereNotNull مع بعض
  Future<void> getUsersWithAndWithoutAvatar() async {
    try {
      emit(GetDataUserLoading());
      final results = await _dbHelper
          .table('users')
          .whereNull('avatar') // مستخدمين مفيش عندهم صورة
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(
        GetDataUserError('Failed to load users with and without avatar: $e'),
      );
    }
  }

  // هتلي المستخدمين الي رقم الموبيل بتعتهم بيبدأ ب '010'
  Future<void> getUsersWithPhoneStartingWith010() async {
    try {
      emit(GetDataUserLoading());
      final results = await _dbHelper
          .table('users')
          .whereLike('phone', '010%') // رقم الموبايل بيبدأ ب '010'
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(
        GetDataUserError(
          'Failed to load users with phone starting with 010: $e',
        ),
      );
    }
  }

  // whereBetween لجلب المستخدمين اللي اتولدوا في فترة معينة
  Future<void> getUsersCreatedBetween(String startDate, String endDate) async {
    try {
      emit(GetDataUserLoading());
      final results = await _dbHelper
          .table('users')
          .whereBetween('created_at', startDate, endDate)
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(
        GetDataUserError(
          'Failed to load users created between $startDate and $endDate: $e',
        ),
      );
    }
  }

  // whereRaw لجلب المستخدمين اللي ايميلهم من دومين معين
  Future<void> getUsersByEmailDomain(String domain) async {
    try {
      emit(GetDataUserLoading());
      final results = await _dbHelper.table('users').whereRaw('email LIKE ?', [
        '%@$domain',
      ]).get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(
        GetDataUserError('Failed to load users with email domain $domain: $e'),
      );
    }
  }

  // join مثال لجلب المستخدمين مع بيانات اضافية من جدول تاني
  Future<void> getUsersWithRoles() async {
    try {
      emit(GetDataUserLoading());
      // {
      //           'name': 'Super Admin',
      //           'email': 'admin@admin.com',
      //           'password_hash': _hashPassword(),
      //           'token': _generateToken('admin@admin.com'),
      //           'role_id': roleId,
      //           'is_active': 1,
      //           'created_at': now,
      //           'updated_at': now,
      //         },
      //         {
      //           'name': 'Super Admin 2',
      //           'email': 's@s.com',
      //           'password_hash': _hashPassword(),
      //           'token': _generateToken('s@s.com'),
      //           'role_id': roleId,
      //           'is_active': 1,
      //           'created_at': now,
      //           'updated_at': now,
      //         },
      //  QueryBuilder join(
      //       String table, String first, String operator, String second)
      final results = await _dbHelper
          .table('admins')
          .join('roles', 'admins.role_id', '=', 'roles.id')
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load users with roles: $e'));
    }
  }

  //orderBy لجلب المستخدمين مرتبين حسب الاسم
  Future<void> getUsersOrderedByName() async {
    try {
      emit(GetDataUserLoading());
      //  QueryBuilder orderBy(String column, {String direction = 'ASC'})
      final results = await _dbHelper
          .table('users')
          .orderBy('first_name', direction: false ? 'ASC' : 'DESC')
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load users ordered by name: $e'));
    }
  }

  //orderByRaw لجلب المستخدمين مرتبين حسب الاسم بطريقة مخصصة
  Future<void> getUsersOrderedByNameRaw() async {
    try {
      emit(GetDataUserLoading());
      //  QueryBuilder orderByRaw(String sql, [List<dynamic>? arguments])
      final results = await _dbHelper
          .table('users')
          .orderByRaw('LENGTH(first_name) DESC, first_name ASC')
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load users ordered by name (raw): $e'));
    }
  }

  // groupBy لجلب عدد المستخدمين النشطين وغير النشطين
  Future<void> getUserCountGroupedByActiveStatus() async {
    try {
      emit(GetDataUserLoading());
      //  QueryBuilder groupBy(String column)
      final results = await _dbHelper.table('users').groupBy('is_active').get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(
        GetDataUserError(
          'Failed to load user count grouped by active status: $e',
        ),
      );
    }
  }

  // groupBy لجلب عدد المستخدمين النشطين فقط مع having
  Future<void> getActiveUserCountHavingMoreThan() async {
    try {
      emit(GetDataUserLoading());
      //  QueryBuilder groupBy(String column)
      // !is_active
      final results = await _dbHelper
          .table('users')
          .groupBy('is_active')
          //QueryBuilder having(String havingClause)
          // is_active = 1
          .having('is_active = 1')
          .get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(
        GetDataUserError(
          'Failed to load active user count having more than : $e',
        ),
      );
    }
  }

  // limit لجلب عدد محدود من المستخدمين
  Future<void> getLimitedUsers() async {
    try {
      emit(GetDataUserLoading());
      //  QueryBuilder limit(int value, [int? offset])
      final results = await _dbHelper.table('users').limit(7).get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load limited users: $e'));
    }
  }

  // offset للتخطي عدد معين من المستخدمين
  Future<void> getUsersWithOffset() async {
    try {
      emit(GetDataUserLoading());
      //  QueryBuilder offset(int value)
      // error I/flutter ( 3685): ❌ Query failed: DatabaseException(near "0": syntax error (code 1 SQLITE_ERROR): , while compiling: SELECT * FROM users OFFSET 0) sql 'SELECT * FROM users OFFSET 0' args []

      final results = await _dbHelper.table('users').offset(1).get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(GetDataUserError('Failed to load users with offset: $e'));
    }
  }

  // groupWhere لجلب المستخدمين بناءً على شروط مجمعة
  Future<void> getUsersWithGroupedConditions() async {
    try {
      emit(GetDataUserLoading());
      //  QueryBuilder groupWhere(Function(QueryBuilder qb) conditions)
      final results = await _dbHelper.table('users').groupWhere((qb) {
        qb.where('is_active', 1);
        qb.orWhere('is_verified', 1);
      }).get();
      final users = results.map((userMap) => User.fromMap(userMap)).toList();
      emit(GetDataUserLoaded(users));
    } catch (e) {
      emit(
        GetDataUserError('Failed to load users with grouped conditions: $e'),
      );
    }
  }

  // تحديث State
  void reset() {
    emit(GetDataUserInitial());
  }
}

class GetDataUserState {}

class GetDataUserInitial extends GetDataUserState {}

class GetDataUserLoading extends GetDataUserState {}

class GetDataUserLoaded extends GetDataUserState {
  final List<User> users;
  GetDataUserLoaded(this.users);
}

class GetDataUserError extends GetDataUserState {
  final String message;
  GetDataUserError(this.message);
}
