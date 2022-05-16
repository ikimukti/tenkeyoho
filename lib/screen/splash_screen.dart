import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenkoyoho2/screen/weather_app.dart';
import 'package:tenkoyoho2/screen/weather_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String route = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool add = true;
  @override
  void initState() {
    super.initState();
    splashScreenStart();
  }

  @override
  void didChangeDependencies() {
    if (add) {
      super.didChangeDependencies();
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) {
          Provider.of<WeatherViewModel>(context, listen: false)
              .getAllWeathers();
        },
      );
      add = false;
    }
  }

  splashScreenStart() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushNamedAndRemoveUntil(
        context, WeatherAppScreen.route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tornado.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Image(
                image: AssetImage('assets/splash.png'),
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
