import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenkoyoho2/model/db_manager/db_manager.dart';
import 'package:tenkoyoho2/screen/weather_detail/weather_detail_screen.dart';
import 'package:tenkoyoho2/screen/weather_indonesia/weather_indonesia_screen.dart';
import 'package:tenkoyoho2/screen/weather_indonesia/weather_indonesia_viewmodel.dart';
import 'package:tenkoyoho2/screen/weather_search/weather_search_screen.dart';
import 'package:tenkoyoho2/screen/weather_user_viewmodel.dart';
import 'package:tenkoyoho2/screen/weather_viewmodel.dart';
import 'package:tenkoyoho2/screen/weather_app.dart';
import 'package:tenkoyoho2/screen/weather_world/weather_world_screen.dart';
import 'package:tenkoyoho2/screen/weather_world/weather_world_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      child: const MyApp(),
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DbManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => WeatherUserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => WeatherWorldViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => WeatherIndoViewModel(),
        ),
      ],
    ),
  );
}

PageRouteBuilder routeBuilder(
  Widget widget,
  RouteSettings routeSettings,
) {
  return PageRouteBuilder(
    settings: routeSettings,
    pageBuilder: (_, __, ___) => widget,
    transitionsBuilder: (_, animation, __, child) {
      final tween = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOut));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (set) {
        switch (set.name) {
          case WeatherAppScreen.route:
            return routeBuilder(const WeatherAppScreen(), set);
          case WeatherWorldScreen.route:
            return routeBuilder(const WeatherWorldScreen(), set);
          case WeatherIndoScreen.route:
            return routeBuilder(const WeatherIndoScreen(), set);
          case WeatherDetailScreen.route:
            return routeBuilder(const WeatherDetailScreen(), set);
          case WeatherSearchScreen.route:
            return routeBuilder(const WeatherSearchScreen(), set);
          default:
            return routeBuilder(const WeatherAppScreen(), set);
        }
      },
    );
  }
}
