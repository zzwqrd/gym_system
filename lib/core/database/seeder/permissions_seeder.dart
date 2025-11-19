import 'package:sqflite/sqflite.dart';

import 'seeder.dart';

/// Seeder خاص بإدخال البيانات الأولية لجداول الصلاحيات (permissions) وربط الأدوار بالصلاحيات (role_permissions).
class PermissionsSeeder implements Seeder {
  @override
  String get name => 'permissions_seeder';

  @override
  Future<void> run(DatabaseExecutor db) async {
    // إدراج الصلاحيات الأساسية
    final permissions = [
      {
        'name': 'users.view',
        'display_name': 'عرض المستخدمين',
        'description': 'السماح بعرض قائمة المستخدمين'
      },
      {
        'name': 'users.create',
        'display_name': 'إنشاء مستخدمين',
        'description': 'السماح بإنشاء مستخدمين جدد'
      },
      {
        'name': 'users.edit',
        'display_name': 'تعديل المستخدمين',
        'description': 'السماح بتعديل معلومات المستخدمين'
      },
      {
        'name': 'users.delete',
        'display_name': 'حذف المستخدمين',
        'description': 'السماح بحذف المستخدمين'
      },
      {
        'name': 'admins.view',
        'display_name': 'عرض المديرين',
        'description': 'السماح بعرض قائمة المديرين'
      },
      {
        'name': 'admins.create',
        'display_name': 'إنشاء مديرين',
        'description': 'السماح بإنشاء مديرين جدد'
      },
      {
        'name': 'admins.edit',
        'display_name': 'تعديل المديرين',
        'description': 'السماح بتعديل معلومات المديرين'
      },
      {
        'name': 'admins.delete',
        'display_name': 'حذف المديرين',
        'description': 'السماح بحذف المديرين'
      },
      {
        'name': 'products.view',
        'display_name': 'عرض المنتجات',
        'description': 'السماح بعرض قائمة المنتجات'
      },
      {
        'name': 'products.create',
        'display_name': 'إنشاء منتجات',
        'description': 'السماح بإنشاء منتجات جديدة'
      },
      {
        'name': 'products.edit',
        'display_name': 'تعديل المنتجات',
        'description': 'السماح بتعديل معلومات المنتجات'
      },
      {
        'name': 'products.delete',
        'display_name': 'حذف المنتجات',
        'description': 'السماح بحذف المنتجات'
      },
      {
        'name': 'categories.view',
        'display_name': 'عرض الفئات',
        'description': 'السماح بعرض قائمة الفئات'
      },
      {
        'name': 'categories.create',
        'display_name': 'إنشاء فئات',
        'description': 'السماح بإنشاء فئات جديدة'
      },
      {
        'name': 'categories.edit',
        'display_name': 'تعديل الفئات',
        'description': 'السماح بتعديل معلومات الفئات'
      },
      {
        'name': 'categories.delete',
        'display_name': 'حذف الفئات',
        'description': 'السماح بحذف الفئات'
      },
      {
        'name': 'orders.view',
        'display_name': 'عرض الطلبات',
        'description': 'السماح بعرض قائمة الطلبات'
      },
      {
        'name': 'orders.edit_status',
        'display_name': 'تعديل حالة الطلبات',
        'description': 'السماح بتعديل حالة الطلبات'
      },
    ];

    for (var p in permissions) {
      await db.insert(
          'permissions',
          {
            'permission_name': p['name'],
            'display_name': p['display_name'],
            'description': p['description'],
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          },
          conflictAlgorithm: ConflictAlgorithm
              .ignore); // استخدم ignore لتجنب إعادة الإدراج عند إعادة التشغيل
    }

    // ربط الصلاحيات بالأدوار
    // ملاحظة: هذا يفترض أن جدول 'roles' قد تم إنشاؤه وتعبئته مسبقًا (مثلاً، في مايجريشن 'roles_table').
    // ويفترض أن 'super_admin' له id = 1 و 'editor' له id = 2.
    final List<Map<String, dynamic>> allPermissions =
        await db.query('permissions');
    for (var p in allPermissions) {
      await db.insert(
          'role_permissions',
          {
            'role_id': 1, // يفترض أن 'super_admin' له id 1
            'permission_id': p['id'],
          },
          conflictAlgorithm: ConflictAlgorithm.ignore);
    }

    // ربط بعض الصلاحيات لدور 'editor' (id = 2)
    final editorPermissionsNames = [
      'products.view',
      'products.create',
      'products.edit',
      'products.delete',
      'categories.view',
      'categories.create',
      'categories.edit',
      'categories.delete',
      'orders.view',
      'orders.edit_status',
    ];
    for (var pName in editorPermissionsNames) {
      final permission = await db.query('permissions',
          where: 'permission_name = ?', whereArgs: [pName]);
      if (permission.isNotEmpty) {
        await db.insert(
          'role_permissions',
          {
            'role_id': 2, // يفترض أن 'editor' له id 2
            'permission_id': permission.first['id'],
          },
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }
  }
}
