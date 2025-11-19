import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../db_helper.dart';

class ExportHelper {
  /// يصدر جميع الصيغ (JSON, CSV, TXT, Excel)
  static Future<void> exportAllFormats({required String tableName}) async {
    final data = await DBHelper().table(tableName).get();

    final List<String> headers = data.isNotEmpty
        ? data.first.keys.map((e) => e.toString()).toList()
        : <String>[];

    final exportDir = await _getExportDirectory();

    // await _exportAsJson(tableName, data, exportDir);
    // await _exportAsCSV(tableName, data, headers, exportDir);
    await _exportAsText(tableName, data, headers, exportDir);
    // await _exportAsExcel(tableName, data, headers, exportDir);
  }

  /// 📁 تحديد مجلد التنزيلات
  static Future<Directory> _getExportDirectory() async {
    Directory? dir;

    try {
      if (Platform.isAndroid || Platform.isMacOS) {
        final base = Directory('/storage/emulated/0/');
        dir = Directory(join(base.path, 'flutter_sq'));
      } else {
        // iOS و غيرها
        final base = await getApplicationDocumentsDirectory();
        dir = Directory(join(base.path, 'flutter_sq'));
      }

      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
    } catch (e) {
      print('❌ Failed to access export dir: $e');
      throw Exception('Failed to access export directory');
    }

    return dir;
  }

  /// 📤 تصدير JSON
  static Future<void> _exportAsJson(
      String table, List<Map<String, dynamic>> data, Directory dir) async {
    final file = File(join(dir.path, '$table.json'));
    await file.writeAsString(jsonEncode(data));
    print('✅ Exported JSON: ${file.path}');
  }

  /// 📤 تصدير CSV
  static Future<void> _exportAsCSV(
      String table,
      List<Map<String, dynamic>> data,
      List<String> headers,
      Directory dir) async {
    final csv = StringBuffer();
    csv.writeln(headers.join(','));
    for (final row in data) {
      csv.writeln(headers.map((h) => row[h]?.toString() ?? '').join(','));
    }

    final file = File(join(dir.path, '$table.csv'));
    await file.writeAsString(csv.toString());
    print('✅ Exported CSV: ${file.path}');
  }

  /// 📤 تصدير TXT
  static Future<void> _exportAsText(
    String table,
    List<Map<String, dynamic>> data,
    List<String> headers,
    Directory dir,
  ) async {
    final buffer = StringBuffer();
    for (final row in data) {
      for (final h in headers) {
        buffer.writeln('$h: ${row[h] ?? ''}');
      }
      buffer.writeln('---');
    }

    final file = File(join(dir.path, '$table.txt'));
    await file.writeAsString(buffer.toString());
    print('✅ Exported TXT: ${file.path}');
  }

  /// 📤 تصدير Excel
  // static Future<void> _exportAsExcel(
  //     String table,
  //     List<Map<String, dynamic>> data,
  //     List<String> headers,
  //     Directory dir,
  //     ) async {
  //   final excel = Excel.createExcel();
  //   final sheet = excel[table];
  //
  //   // ✅ تحويل headers إلى CellValue
  //   sheet.appendRow(headers.map((e) => CellValue.fromString(e)).toList());
  //
  //   for (final row in data) {
  //     sheet.appendRow(
  //       headers.map((h) => CellValue.fromString(row[h]?.toString() ?? '')).toList(),
  //     );
  //   }
  //
  //   final file = File(join(dir.path, '$table.xlsx'));
  //   await file.writeAsBytes(excel.encode()!);
  //   print('✅ Exported Excel: ${file.path}');
  // }
}

// import 'dart:convert';
// import 'dart:io';
//
// import 'package:excel/excel.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
//
// import '../db_helper.dart';
//
// class ExportHelper {
//   static Future<void> exportAllFormats({required String tableName}) async {
//     final data = await DBHelper()
//         .table(tableName)
//         .get(); // Assuming get() fetches all rows
//     final headers = data.isNotEmpty
//         ? data.first.keys.map((e) => e.toString()).toList()
//         : [];
//
//     final dir = await getApplicationDocumentsDirectory();
//     final exportDir = Directory(join(dir.path, 'flutter_sq'));
//     if (!await exportDir.exists()) await exportDir.create(recursive: true);
//
//     await _exportAsJson(tableName, data, exportDir);
//     await _exportAsCSV(tableName, data, headers, exportDir);
//     await _exportAsText(tableName, data, headers, exportDir);
//     await _exportAsExcel(tableName, data, headers, exportDir);
//     // await _exportAsPDF(tableName, data, headers, exportDir);
//   }
//
//   static Future<void> _exportAsJson(
//     String table,
//     List<Map<String, dynamic>> data,
//     Directory dir,
//   ) async {
//     final file = File(join(dir.path, '$table.json'));
//     await file.writeAsString(jsonEncode(data));
//     print('✅ Exported JSON: ${file.path}');
//   }
//
//   static Future<void> _exportAsCSV(
//       String table,
//       List<Map<String, dynamic>> data,
//       List<dynamic> headers,
//       Directory dir) async {
//     final csv = StringBuffer();
//     csv.writeln(headers.join(','));
//     for (final row in data) {
//       csv.writeln(headers.map((h) => row[h]?.toString() ?? '').join(','));
//     }
//
//     final file = File(join(dir.path, '$table.csv'));
//     await file.writeAsString(csv.toString());
//     print('✅ Exported CSV: ${file.path}');
//   }
//
//   static Future<void> _exportAsText(String table,
//       List<Map<String, dynamic>> data, dynamic headers, Directory dir) async {
//     final buffer = StringBuffer();
//     for (final row in data) {
//       for (final h in headers) {
//         buffer.write('$h: ${row[h]}\n');
//       }
//       buffer.writeln('---');
//     }
//
//     final file = File(join(dir.path, '$table.txt'));
//     await file.writeAsString(buffer.toString());
//     print('✅ Exported TXT: ${file.path}');
//   }
//
//   static Future<void> _exportAsExcel(String table,
//       List<Map<String, dynamic>> data, dynamic headers, Directory dir) async {
//     final excel = Excel.createExcel();
//     final sheet = excel[table];
//
//     sheet.appendRow(headers);
//     for (final row in data) {
//       sheet.appendRow(headers.map((h) => row[h] ?? '').toList());
//     }
//
//     final file = File(join(dir.path, '$table.xlsx'));
//     await file.writeAsBytes(excel.encode()!);
//     print('✅ Exported Excel: ${file.path}');
//   }
//
//   // static Future<void> _exportAsPDF(
//   //   String table,
//   //   List<Map<String, dynamic>> data,
//   //   dynamic headers,
//   //   Directory dir,
//   // ) async {
//   //   final pdf = pw.Document();
//   //   final rows = [
//   //     headers,
//   //     ...data.map((row) => headers.map((h) => '${row[h] ?? ''}').toList()),
//   //   ];
//   //   pdf.addPage(
//   //     pw.Page(
//   //       build: (context) => pw.Table.fromTextArray(data: rows),
//   //     ),
//   //   );
//   //
//   //   final file = File(join(dir.path, '$table.pdf'));
//   //   await file.writeAsBytes(await pdf.save());
//   //   print('✅ Exported PDF: ${file.path}');
//   // }
// }
