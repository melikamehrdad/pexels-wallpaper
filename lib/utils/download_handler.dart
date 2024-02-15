import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<String> getFilePath(
    String url, String photographer, void Function(int, int) progressCallback) async {
  final response = await http.get(Uri.parse(url));
  final documentDirectory = await getApplicationDocumentsDirectory();
  final filePath = '${documentDirectory.path}/$photographer.jpeg';
  final file = File(filePath);

  await file.writeAsBytes(response.bodyBytes, flush: true);

  return filePath;
}
