import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ghibli_movie_gallery_browser/app/theme/light_theme.dart';
import 'package:ghibli_movie_gallery_browser/core/provider/shared_preferences_provider.dart';
import 'package:ghibli_movie_gallery_browser/movie/page/movie_browsing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(sharedPreferences)], child: const AppRoot()),
  );
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghibli Movie Gallery',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const MovieBrowsingPage(),
    );
  }
}
