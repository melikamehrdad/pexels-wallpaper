import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  Future<String> getWallpaperList(Client http) async {
    Uri wallpapers = Uri.parse('https://api.pexels.com/v1/curated?per_page=20');
    final response = await http.get(wallpapers, headers: {
      'Authorization':
          'dRqfYTRMyHaxASyoYLrWcYKXSoYHQmZBc5WReYOLO7OxCwmpYVBq9ITG',
    });
    if (response.statusCode == 200) {
      final Map wallpaperJSON = jsonDecode(response.body);
      return wallpaperJSON['photographer'];
    } else {
      return 'Failed to fetch wallpaper';
    }
  }

  group('getWallpaperList', () {
    test('returns wallpaper data when http response is successful', () async {
      // Mock the API call to return a json response with http status 200 Ok //
      final mockHTTPClient = MockClient((request) async {
        // Create sample response of the HTTP call //
        final response = {
          'id': '1',
          'url': 'https://www.example.com',
          'photographer': 'John Doe',
          'photographer_url': 'https://www.example.com/johndoe',
          'src': {
            'original': 'https://www.example.com/original.jpg',
            'large2x': 'https://www.example.com/large2x.jpg',
            'large': 'https://www.example.com/large.jpg',
            'medium': 'https://www.example.com/medium.jpg',
            'small': 'https://www.example.com/small.jpg',
            'portrait': 'https://www.example.com/portrait.jpg',
            'landscape': 'https://www.example.com/landscape.jpg',
            'tiny': 'https://www.example.com/tiny.jpg'
          }
        };
        return Response(jsonEncode(response), 200);
      });
      // Check whether getNumberTrivia function returns
      // number trivia which will be a String
      expect(await getWallpaperList(mockHTTPClient), isA<String>());
    });

    test('return error message when http response is unsuccessful', () async {
      // Mock the API call to return an
      // empty json response with http status 404
      final mockHTTPClient = MockClient((request) async {
        final response = {};
        return Response(jsonEncode(response), 404);
      });
      expect(
          await getWallpaperList(mockHTTPClient), 'Failed to fetch wallpaper');
    });
  });
}
