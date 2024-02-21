import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_project/data/wallpaper_model.dart';
import 'package:wallpaper_project/presentation/pages/home_page.dart';

void main() {
  group('HomePage', () {
    final List<WallpaperModel> wallpapers = [];

    testWidgets('renders AppBar with correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final appBarFinder = find.byType(AppBar);
      final titleFinder = find.text('Wallpapers');

      expect(appBarFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('renders CircularProgressIndicator when isLoading is true',
        (WidgetTester tester) async {
      const homePage = HomePage();

      await tester.pumpWidget(const MaterialApp(home: homePage));

      final progressIndicatorFinder = find.byType(CircularProgressIndicator);

      expect(progressIndicatorFinder, findsOneWidget);
    });

    testWidgets(
        'renders "No more wallpapers." when isLoading is false and _wallpapers is empty',
        (WidgetTester tester) async {
      const homePage = HomePage();
      wallpapers.clear();

      await tester.pumpWidget(const MaterialApp(home: homePage));

      final noMoreWallpapersFinder = find.text('No more wallpapers.');

      expect(noMoreWallpapersFinder, findsOneWidget);
    });

    testWidgets('renders ListTile for each wallpaper in _wallpapers',
        (WidgetTester tester) async {
      const homePage = HomePage();
      wallpapers.addAll([
        WallpaperModel(
          photographer: 'James Superschoolnews',
          alt: 'Beautiful landscape',
          avgColor: 'rgb(0, 0, 0)',
          height: 1000,
          width: 1500,
          id: 1,
          liked: false,
          photographerId: 1,
          photographerUrl: 'https://example.com/james',
          url: 'https://example.com/image.jpg',
          src: {'tiny': 'https://example.com/image.jpg'},
        ),
        WallpaperModel(
          photographer: 'Nguyễn Bảo Trung',
          alt: 'Beautiful landscape',
          avgColor: 'rgb(0, 0, 0)',
          height: 1000,
          width: 1500,
          id: 1,
          liked: false,
          photographerId: 1,
          photographerUrl: 'https://example.com/nguy',
          url: 'https://example.com/image.jpg',
          src: {'tiny': 'https://example.com/image.jpg'},
        ),
      ]);

      await tester.pumpWidget(const MaterialApp(home: homePage));

      final listTileFinder1 = find.byWidgetPredicate((widget) =>
          widget is ListTile && widget.title == const Text('Jane Smith'));

      final listTileFinder2 = find.byWidgetPredicate((widget) =>
          widget is ListTile && widget.title == const Text('John Doe'));

      expect(listTileFinder1, findsOneWidget);
      expect(listTileFinder2, findsOneWidget);
    });
  });
}
