import 'dart:convert';

import 'package:wallpaper_project/data/wallpaper_model.dart';
import 'package:http/http.dart' as http;

// The WallpaperRepository class is responsible for fetching wallpapers from the Pexels API.
class WallpaperRepository {
  Future<List<WallpaperModel>> fetchAllWallpapers(int page) async {
    final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?page=$page&per_page=20'),
        headers: {
          'Authorization':
              'YOUR-TOKEN-HERE',
        });
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final wallpapersJson = jsonBody['photos'];
      return wallpapersJson
              .map<WallpaperModel>((json) => WallpaperModel.fromJson(json))
              .toList() ??
          [];
    } else {
      throw Exception('Failed to fetch wallpapers');
    }
  }
}
