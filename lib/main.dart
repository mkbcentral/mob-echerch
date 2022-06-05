import 'package:echurch/pages/loading_page.dart';
import 'package:echurch/pages/on_boarding_page.dart';
import 'package:echurch/pages/ui/themes/main_theme.dart';
import 'package:echurch/pages/ui/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eChurch',
      theme: Themes.light,
      themeMode: ThemeService().theme,
      darkTheme: Themes.dark,
      home: showHome ? const LoadingPage() : const OnBoardingPage(),
    );
  }
}
