import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<String> getFilePath(String url, String photographer,
    void Function(int, int) progressCallback) async {
  final http.Response response = await http.get(Uri.parse(url));
  final documentDirectory = await getApplicationDocumentsDirectory();
  final filePath = '${documentDirectory.path}/$photographer.jpeg';
  final file = File(filePath);

  final totalBytes = response.contentLength;
  var receivedBytes = 0;

  final sink = file.openWrite();

  // Listen for the data and write it to the file
  // while keeping track of the progress
  file.openRead().listen(
    (data) {
      receivedBytes += data.length;
      progressCallback(receivedBytes, totalBytes!);
      sink.add(data);
    },
    onDone: () {
      sink.close();
    },
    onError: (error) {
      sink.close();
    },
  );

  return filePath;
}
