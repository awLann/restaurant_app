import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/local/local_database_service.dart';
import 'package:restaurant_app/provider/index_nav_provider.dart';
import 'package:restaurant_app/provider/local_database_provider.dart';
import 'package:restaurant_app/provider/local_notification_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/theme_prefs_provider.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/static/navigation_route.dart';
import 'package:restaurant_app/style/custom_theme.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => IndexNavProvider(),
      ),
      Provider(
        create: (context) => ApiServices(),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantListProvider(
          context.read<ApiServices>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantDetailProvider(
          context.read<ApiServices>(),
        ),
      ),
      Provider(
        create: (context) => LocalDatabaseService(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocalDatabaseProvider(
          context.read<LocalDatabaseService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemePrefsProvider()..getThemePrefs(),
      ),
      Provider(
        create: (context) => LocalNotificationService()
          ..init()
          ..configureLocalTimeZone(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocalNotificationProvider(
          context.read<LocalNotificationService>()..requestPermission(),
        ),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemePrefsProvider>();
    return MaterialApp(
      title: 'Restaurant App',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
