import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tenkoyoho2/screen/weather_indonesia/weather_indonesia_screen.dart';
import 'package:tenkoyoho2/screen/weather_world/weather_world_screen.dart';

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatefulWidget {
  String navIndex = '';
  NavigationDrawerWidget({
    Key? key,
    required this.navIndex,
  }) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Tenkoyoho App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/tornado.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Weather World',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.cloud_circle),
            subtitle: Text(
              'International Weather Forecast',
              style: GoogleFonts.lato(
                fontSize: 11,
              ),
            ),
            onTap: () {
              if (widget.navIndex != WeatherWorldScreen.route) {
                Navigator.pushReplacementNamed(
                    context, WeatherWorldScreen.route);
              }
            },
          ),
          ListTile(
            title: Text(
              'Weather Indonesia',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.cloud_circle),
            subtitle: Text(
              'Indonesian Weather Forecast',
              style: GoogleFonts.lato(
                fontSize: 11,
              ),
            ),
            onTap: () {
              if (widget.navIndex != WeatherIndoScreen.route) {
                Navigator.pushReplacementNamed(
                    context, WeatherIndoScreen.route);
              }
            },
          ),
          ListTile(
            title: Text(
              'About',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}
