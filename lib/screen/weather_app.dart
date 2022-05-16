import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:tenkoyoho2/model/data/static_data.dart';
// import 'package:tenkoyoho2/model/weather_locations.dart';
import 'package:tenkoyoho2/screen/weather_user_viewmodel.dart';
import 'package:tenkoyoho2/screen/weather_viewmodel.dart';
// import 'package:tenkoyoho2/screen/weather_world_screen.dart';
import 'package:tenkoyoho2/service/location_service.dart';
// import 'package:tenkoyoho2/widgets/buildin_transform.dart';
import 'package:tenkoyoho2/widget/navigation_drawer.dart';
// import 'package:tenkoyoho2/widget/single_weather.dart';
// import 'package:tenkoyoho2/widget/slider_dot.dart';

class WeatherAppScreen extends StatefulWidget {
  const WeatherAppScreen({Key? key}) : super(key: key);
  static const String route = '/weather_app';

  @override
  State<WeatherAppScreen> createState() => _WeatherAppScreenState();
}

class _WeatherAppScreenState extends State<WeatherAppScreen> {
  LocationService locationService = LocationService();
  double latitude = 0.0;
  double longitude = 0.0;
  String? address = '';
  double accuracy = 0.0;
  double altitude = 0.0;
  double speed = 0.0;
  double speedAccuracy = 0.0;
  double heading = 0.0;
  DateTime? timestamp = DateTime.now();
  String? name = '';
  String? street = '';
  String? isoCountryCode = '';
  String? country = '';
  String? postalCode = '';
  String? administrativeArea = '';
  String? subAdministrativeArea = '';
  String? locality = '';
  String? subLocality = '';
  String? thoroughfare = '';
  String? subThoroughfare = '';
  // int _currentPage = 0;
  late String bgImg;
  bool add = true;

  @override
  initState() {
    super.initState();
    locationService.locationStream.listen(
      (userLocation) {
        // postalCode = userLocation.postalCode;
        // isoCountryCode = userLocation.isoCountryCode;
        latitude = userLocation.latitude;
        longitude = userLocation.longitude;
        Provider.of<WeatherUserViewModel>(context, listen: false)
            .getWeathers(latitude, longitude);
        Provider.of<WeatherViewModel>(context, listen: false).getAllWeathers();
        // setState(
        //   () {
        //     latitude = userLocation.latitude;
        //     longitude = userLocation.longitude;
        //     address = userLocation.address;
        //     accuracy = userLocation.accuracy;
        //     altitude = userLocation.altitude;
        //     speed = userLocation.speed;
        //     speedAccuracy = userLocation.speedAccuracy;
        //     heading = userLocation.heading;
        //     timestamp = userLocation.timestamp;
        //     name = userLocation.name;
        //     street = userLocation.street;
        //     isoCountryCode = userLocation.isoCountryCode;
        //     country = userLocation.country;
        //     postalCode = userLocation.postalCode;
        //     administrativeArea = userLocation.administrativeArea;
        //     subAdministrativeArea = userLocation.subAdministrativeArea;
        //     locality = userLocation.locality;
        //     subLocality = userLocation.subLocality;
        //     thoroughfare = userLocation.thoroughfare;
        //     subThoroughfare = userLocation.subThoroughfare;
        //   },
        // );
      },
    );
    // if (add) {
    // super.didChangeDependencies();
    // WidgetsBinding.instance?.addPostFrameCallback(
    //   (_) {
    //     Provider.of<WeatherViewModel>(context, listen: false)
    //         .getAllWeathers();
    //   },
    // );
    // WidgetsBinding.instance?.addPostFrameCallback(
    //   (_) {

    // },
    // );
    //   add = false;
    // }
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {

  // }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context);
    if (weatherViewModel.weathers.isEmpty) {
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
    final weatherUserViewModel = Provider.of<WeatherUserViewModel>(context);
    if (weatherUserViewModel.weathers.cityName == '') {
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
      //     'This is data from weatherUserViewModel: ${weatherUserViewModel.weathers}');
    }
    String? wT = weatherUserViewModel.weathers.data![0].weather?.description;
    // String? wT = 'Thunderstorm with light rain';

    List<Map> weatherTypes = StaticData.weatherTypes;
    // print('This is weatherTypes: ${weatherTypes.length}');
    for (int i = 0; i < weatherTypes.length; i++) {
      if (weatherTypes[i]['weatherType'] == wT) {
        bgImg = weatherTypes[i]['bg'];
        // print('This is bgImg: $bgImg');
      }
    }
    double? widthWindSpd = 0;
    if (weatherUserViewModel.weathers.data![0].windSpd > 0) {
      widthWindSpd = weatherUserViewModel.weathers.data![0].windSpd.toDouble();
      if (widthWindSpd! > 50) {
        widthWindSpd = 50;
      }
    }
    double? widthHumidity = 0;
    if (weatherUserViewModel.weathers.data![0].rh! > 0) {
      widthHumidity = weatherUserViewModel.weathers.data![0].rh!.toDouble();
      if (widthHumidity > 50) {
        widthHumidity = 50;
      }
    }
    double? widthVis = 0;
    if (weatherUserViewModel.weathers.data![0].vis! > 0) {
      widthVis = weatherUserViewModel.weathers.data![0].vis!.toDouble();
      if (widthVis! > 50) {
        widthVis = 50;
      }
    }

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
                  (Route<dynamic> route) => false,
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
                              '${weatherUserViewModel.weathers.cityName}',
                              style: GoogleFonts.lato(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${weatherUserViewModel.weathers.timezone}',
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
                              '${weatherUserViewModel.weathers.data![0].temp}°',
                              style: GoogleFonts.lato(
                                fontSize: 85,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      'https://www.weatherbit.io/static/img/icons/${weatherUserViewModel.weathers.data![0].weather!.icon}.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${weatherUserViewModel.weathers.data![0].weather!.description}',
                                      style: GoogleFonts.lato(
                                        fontSize: 20,
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
                                            fontSize: 16,
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
                                          size: 20,
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
                                  '${weatherUserViewModel.weathers.data![0].windSpd}',
                                  style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'km/h',
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
                                  '${weatherUserViewModel.weathers.data![0].rh}',
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
                                  '${weatherUserViewModel.weathers.data![0].vis}',
                                  style: GoogleFonts.lato(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'km',
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
            ),
          ],
        ),
      ),
    );
  }
}
