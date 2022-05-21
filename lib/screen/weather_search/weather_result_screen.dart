import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tenkoyoho2/model/data/static_data.dart';
import 'package:tenkoyoho2/screen/weather_app.dart';
import 'package:tenkoyoho2/screen/weather_search/weather_search_screen.dart';
import 'package:tenkoyoho2/screen/weather_search/weather_search_viewmodel.dart';
import 'package:tenkoyoho2/widget/navigation_drawer.dart';
import 'package:tenkoyoho2/widget/slider_dot.dart';

class WeatherResultScreen extends StatefulWidget {
  const WeatherResultScreen({Key? key}) : super(key: key);
  static const String route = '/weather_result';

  @override
  State<WeatherResultScreen> createState() => _WeatherResultScreenState();
}

class _WeatherResultScreenState extends State<WeatherResultScreen> {
  final String _navIndex = '/weather_result';
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
    final Map datas = ModalRoute.of(context)?.settings.arguments as Map;
    double latitude = datas['lat'] ?? 0;
    double longitude = datas['lon'] ?? 0;

    final WeatherSearchViewModel weatherViewModel =
        Provider.of<WeatherSearchViewModel>(context);
    if (weatherViewModel.weathers.cityName == null) {
      Provider.of<WeatherSearchViewModel>(context, listen: false)
          .getWeathers(latitude, longitude);
      return Container(
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
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                semanticsLabel: 'Loading...',
                semanticsValue: 'Loading...',
              ),
            ],
          ),
        ),
      );
    } else {
      // print(
      //     'This is data from weatherViewModel: ${weatherViewModel.weathers.length}');
    }
    String? wT =
        weatherViewModel.weathers.data![_currentPage].weather!.description;
    // print('This is wT: $wT');

    // print('This is bgImg: $bgImg');
    List<Map> weatherTypes = StaticData.weatherTypes;
    // print('This is weatherTypes: ${weatherTypes.length}');
    for (int i = 0; i < weatherTypes.length; i++) {
      // print(weatherTypes[i]['weatherType']);
      // print(wT);
      // print('$wT = ${weatherTypes[i]['weatherType']}');
      if (weatherTypes[i]['weatherType'] == wT) {
        // print(
        //     'This is weatherTypes[i][\'weatherType\']: ${weatherTypes[i]['weatherType']}');
        bgImg = weatherTypes[i]['bg'];
        // print('This is bgImg: $bgImg');
        break;
      }
    }

    double? widthWindSpd = 0;
    if (weatherViewModel.weathers.data![0].windSpd > 0) {
      widthWindSpd = weatherViewModel.weathers.data![0].windSpd.toDouble();
      if (widthWindSpd! > 50) {
        widthWindSpd = 50;
      }
    }
    double? widthHumidity = 0;
    if (weatherViewModel.weathers.data![0].rh! > 0) {
      widthHumidity = weatherViewModel.weathers.data![0].rh!.toDouble();
      if (widthHumidity > 50) {
        widthHumidity = 50;
      }
    }
    double? widthVis = 0;
    if (weatherViewModel.weathers.data![0].vis! > 0) {
      widthVis = weatherViewModel.weathers.data![0].vis!.toDouble();
      if (widthVis! > 50) {
        widthVis = 50;
      }
    }
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: NavigationDrawerWidget(navIndex: _navIndex),
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
                if (_navIndex != '/') {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    WeatherAppScreen.route,
                    (route) => false,
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                if (_navIndex != '/weather_search') {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    WeatherSearchScreen.route,
                    (route) => false,
                  );
                }
              },
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
              margin: const EdgeInsets.only(top: 100, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      for (int index = 0;
                          index < weatherViewModel.weathers.data!.length;
                          index++)
                        if (index == _currentPage)
                          SliderDotWidget(
                            isActive: true,
                          )
                        else
                          SliderDotWidget(
                            isActive: false,
                          ),
                    ],
                  ),
                ],
              ),
            ),
            PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weatherViewModel.weathers.data!.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return Container(
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
                                  '${weatherViewModel.weathers.cityName}',
                                  style: GoogleFonts.lato(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${weatherViewModel.weathers.data![index].datetime}',
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
                                  'valid : ${weatherViewModel.weathers.data![index].validDate}',
                                  style: GoogleFonts.lato(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${weatherViewModel.weathers.data![index].temp}°',
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
                                          'https://www.weatherbit.io/static/img/icons/${weatherViewModel.weathers.data![index].weather!.icon}.png',
                                          height: 30,
                                          width: 30,
                                          color: Colors.white,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${weatherViewModel.weathers.data![index].weather!.description}',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lato(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                      '${weatherViewModel.weathers.data![index].windSpd}',
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
                                          width: widthWindSpd,
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
                                      '${weatherViewModel.weathers.data![index].rh}',
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
                                          width: widthHumidity,
                                          color: Colors.greenAccent,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Visibility',
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${weatherViewModel.weathers.data![index].vis}',
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
                                          width: widthVis,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
