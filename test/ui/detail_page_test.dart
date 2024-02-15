import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_project/data/wallpaper_model.dart';
import 'package:wallpaper_project/presentation/pages/detail_page.dart';
import 'package:wallpaper_project/presentation/widgets/download_button.dart';
import 'package:wallpaper_project/presentation/widgets/image_widget.dart';

void main() {
  testWidgets('WallpaperDetailPage displays wallpaper details', (WidgetTester tester) async {
    // Create a mock wallpaper model
    final wallpaper = WallpaperModel(
      photographer: 'John Doe',
      alt: 'A beautiful wallpaper',
      avgColor: '#000000',
      height: 1000,
      width: 2000,
      id: 1,
      url: 'https://example.com/image.jpg',
      liked: false,
      photographerId: 1,
      photographerUrl: 'https://example.com/johndoe',
      src: {'large2x': 'https://example.com/image.jpg'},
    );

    // Build the WallpaperDetailPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: WallpaperDetailPage(wallpaper: wallpaper),
      ),
    );

    // Verify that the photographer name is displayed
    expect(find.text('John Doe'), findsOneWidget);

    // Verify that the image widget is displayed
    expect(find.byType(ImageWidget), findsOneWidget);

    // Verify that the download button is displayed
    expect(find.byType(DownloadButton), findsOneWidget);
  });
}
