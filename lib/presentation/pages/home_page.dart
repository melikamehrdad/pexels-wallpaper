import 'package:flutter/material.dart';
import 'package:wallpaper_project/data/wallpaper_model.dart';
import 'package:wallpaper_project/data/wallpaper_repository.dart';
import 'package:wallpaper_project/presentation/pages/detail_page.dart';
import 'package:wallpaper_project/presentation/widgets/list_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  final List<WallpaperModel> _wallpapers = [];
  bool isLoading = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    // Create a ScrollController to listen to the scroll events.
    _scrollController = ScrollController();
    // Add a listener to the ScrollController to listen to the scroll events.
    _scrollController.addListener(_scrollListener);
    // Fetch the wallpapers when the page is loaded.
    _fetchWallpapers();
  }

  @override
  void dispose() {
    // Dispose the ScrollController when the page is disposed.
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // If the user has scrolled to the bottom of the list, fetch more wallpapers.
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchWallpapers();
    }
  }

  Future<void> _fetchWallpapers() async {
    // If the page is not loading, fetch the wallpapers.
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      try {
        // Fetch the wallpapers from the repository.
        final wallpapers =
            await WallpaperRepository().fetchAllWallpapers(_page);
        setState(() {
          // Add the fetched wallpapers to the list of wallpapers.
          _wallpapers.addAll(wallpapers);
          // Increment the page number for the next fetch.
          _page++;
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          // If an error occurred while fetching the wallpapers, set isLoading to false.
          isLoading = false;
        });
        debugPrint('Error occurred while fetching wallpapers: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpapers'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
        ),
        controller: _scrollController,
        // Add 1 to the itemCount to show a loading indicator at the end of the list.
        itemCount: _wallpapers.length + 1,
        itemBuilder: (context, index) {
          // If the index is less than the length of the wallpapers, show the wallpaper.
          if (index < _wallpapers.length) {
            final WallpaperModel wallpaper = _wallpapers[index];

            // Show the wallpaper in a ListTile.
            return ListTileWidget(
              imageUrl: wallpaper.src['tiny']!,
              photographer: wallpaper.photographer,
              onTapCallBack: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WallpaperDetailPage(wallpaper: wallpaper),
                  ),
                );
              },
            );

            // If the index is equal to the length of the wallpapers, show a loading indicator.
          } else if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );

            // If the index is greater than the length of the wallpapers, show a message.
          } else {
            return const Center(
              child: Text('No more wallpapers.'),
            );
          }
        },
      ),
    );
  }
}
