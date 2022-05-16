import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:tenkoyoho2/model/data/static_data.dart';
import 'package:tenkoyoho2/model/weather_locations.dart';
import 'package:tenkoyoho2/model/weather_model.dart';
import 'package:tenkoyoho2/screen/weather_world_viewmodel.dart';
import 'package:tenkoyoho2/screen/weather_app.dart';
// import 'package:tenkoyoho2/screen/weather_viewmodel.dart';
// import 'package:tenkoyoho2/widgets/buildin_transform.dart';
import 'package:tenkoyoho2/widget/navigation_drawer.dart';
// import 'package:tenkoyoho2/widget/single_weather.dart';
import 'package:tenkoyoho2/widget/single_weather_world.dart';
import 'package:tenkoyoho2/widget/slider_dot.dart';

class WeatherDetailScreen extends StatefulWidget {
  const WeatherDetailScreen({Key? key}) : super(key: key);
  static const String route = '/weather_details';

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  int _currentPage = 0;
  late String bgImg = '';
  bool add = true;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Map datass = ModalRoute.of(context)?.settings.arguments as Map;
    String wT = weatherLocations[_currentPage].weatherType;
    WeatherModel wTw = datass['datas'] as WeatherModel;

    List<Map> weatherTypes = StaticData.weatherTypes;
    print('This is weatherTypes: ${weatherTypes.length}');
    for (int i = 0; i < weatherTypes.length; i++) {
      if (weatherTypes[i]['weatherType'] == wTw.data![0].weather!.description) {
        bgImg = weatherTypes[i]['icon'];
      }
    }
    if (bgImg == '') {
      bgImg = 'assets/tornado.jpg';
    }
    double? barHumidity = wTw.data![0].rh?.toDouble();
    barHumidity = (barHumidity! / 2);
    double? barCloud = wTw.data![0].cloudsMid?.toDouble();
    barCloud = (barCloud! / 2);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const NavigationDrawerWidget(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        elevation: 0,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.my_location,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  WeatherAppScreen.route,
                  (route) => false,
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {},
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () {
                // ignore: avoid_print
                print('Tapped Menu');
                _scaffoldKey.currentState?.openEndDrawer();
              },
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              child: Image.asset(
                bgImg,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.2),
                  ],
                ),
              ),
            ),
            Container(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 90,
                              ),
                              Text(
                                '${wTw.cityName}',
                                style: GoogleFonts.lato(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${wTw.countryCode} ${wTw.timezone}',
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${wTw.data![0].validDate}',
                                style: GoogleFonts.lato(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${wTw.data![0].temp}°',
                                style: GoogleFonts.lato(
                                  fontSize: 85,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        'https://www.weatherbit.io/static/img/icons/${wTw.data![0].weather!.icon}.png',
                                        height: 30,
                                        width: 30,
                                        color: Colors.white,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${wTw.data![0].weather!.description}',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lato(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // ignore: avoid_print
                                      print('Tapped Details');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Details',
                                            style: GoogleFonts.lato(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 0.3,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Wind',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${wTw.data![0].windSpd}',
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'm/s',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 5,
                                        width: 50,
                                        color: Colors.white70,
                                      ),
                                      Container(
                                        height: 5,
                                        width: wTw.data![0].windSpd,
                                        color: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Humidity',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${wTw.data![0].rh}',
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '%',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 5,
                                        width: 50,
                                        color: Colors.white70,
                                      ),
                                      Container(
                                        height: 5,
                                        width: barHumidity,
                                        color: Colors.greenAccent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Clouds',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${wTw.data![0].cloudsMid}',
                                    style: GoogleFonts.lato(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'mm',
                                    style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        height: 5,
                                        width: 50,
                                        color: Colors.white70,
                                      ),
                                      Container(
                                        height: 5,
                                        width: barCloud,
                                        color: Colors.yellowAccent,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
