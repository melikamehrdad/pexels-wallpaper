import 'package:flutter/material.dart';
import 'package:wallpaper_project/data/wallpaper_model.dart';
import 'package:wallpaper_project/presentation/widgets/download_button.dart';
import 'package:wallpaper_project/presentation/widgets/image_widget.dart';

class WallpaperDetailPage extends StatefulWidget {
  final WallpaperModel wallpaper;

  const WallpaperDetailPage({Key? key, required this.wallpaper})
      : super(key: key);

  @override
  State<WallpaperDetailPage> createState() => _WallpaperDetailPageState();
}

class _WallpaperDetailPageState extends State<WallpaperDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper Detail'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 3.0,
              ),
            ],
          ),
          child: Column(
            children: [
              // Show the image of the wallpaper.
              ImageWidget(
                imageUrl: widget.wallpaper.src['large2x']!,
              ),

              // space
              const SizedBox(
                height: 20,
              ),

              Text(
                widget.wallpaper.photographer,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // space
              const SizedBox(
                height: 20,
              ),

              // Add a button to download the wallpaper and show snack bar.
              DownloadButton(wallpaper: widget.wallpaper),

              // space
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
