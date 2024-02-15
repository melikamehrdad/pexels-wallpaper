import 'package:flutter/material.dart';
import 'package:wallpaper_project/data/wallpaper_model.dart';
import 'package:wallpaper_project/utils/download_handler.dart';

class DownloadButton extends StatefulWidget {
  final WallpaperModel wallpaper;
  const DownloadButton({super.key, required this.wallpaper});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _downloading = false;
  double _progress = 0.0;

  Future<String> _downloadWallpaper() async {
    // Set the downloading state to true and reset the progress to 0.0.
    setState(() {
      _downloading = true;
      _progress = 0.0;
    });

    final downloadUrl = widget.wallpaper.src['large2x']!;
    // Call the getFilePath function to download the wallpaper.
    final downloadPath = await getFilePath(
        downloadUrl, widget.wallpaper.photographer, (received, total) {
      setState(() {
        _progress = received / total;
      });
    });

    // Set the downloading state to false and reset the progress to 0.0.
    setState(() {
      _downloading = false;
      _progress = 0.0;
    });

    return downloadPath;
  }

  @override
  Widget build(BuildContext context) {
    return _downloading
        ? CircularProgressIndicator(
            value: _progress,
            backgroundColor: Colors.blue,
          )
        : ElevatedButton(
            onPressed: () => _downloadWallpaper().then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Downloaded to $value.',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: const Color(0xFFe91e63),
                ),
              ),
            ),
            child: const Text('Download'),
          );
  }
}
