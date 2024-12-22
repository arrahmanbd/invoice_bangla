import 'dart:io';
import 'package:flutter/services.dart';
import 'package:new_invoice_bangla/constants/constant.dart';
import 'package:pdf/widgets.dart' as invoice;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PDFHelper {
  // save pdf file function
  static Future<File> saveDocument({
    required String name,
    required invoice.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  // open pdf file function
  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  /// laod image as Uint8List
  static Future<Uint8List> loadImage(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  //Loading font as ByteData
  static Future<ByteData> setBanglaFont() async {
    return await rootBundle.load(banglaFont);
  }
}
