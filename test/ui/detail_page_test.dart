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
      photographer: 'James Superschoolnews',
      alt: 'A beautiful wallpaper',
      avgColor: '#1F1110',
      height: 1000,
      width: 2000,
      id: 1,
      url: 'https://www.pexels.com/photo/silhouette-of-a-woman-in-red-sunglasses-20249586/',
      liked: false,
      photographerId: 1,
      photographerUrl: 'https://www.pexels.com/@james-superschoolnews-349383308',
      src: {'large2x': 'https://images.pexels.com/photos/20249586/pexels-photo-20249586.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'},
    );

    // Build the WallpaperDetailPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: WallpaperDetailPage(wallpaper: wallpaper),
      ),
    );

    // Verify that the photographer name is displayed
    expect(find.text('James Superschoolnews'), findsOneWidget);

    // Verify that the image widget is displayed
    expect(find.byType(ImageWidget), findsOneWidget);

    // Verify that the download button is displayed
    expect(find.byType(DownloadButton), findsOneWidget);
  });
}
