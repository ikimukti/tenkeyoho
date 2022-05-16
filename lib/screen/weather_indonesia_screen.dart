import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:tenkoyoho2/model/data/static_data.dart';
import 'package:tenkoyoho2/screen/weather_indonesia_viewmodel.dart';
// import 'package:tenkoyoho2/model/weather_locations.dart';
// import 'package:tenkoyoho2/screen/weather_world_viewmodel.dart';
import 'package:tenkoyoho2/screen/weather_app.dart';
// import 'package:tenkoyoho2/screen/weather_viewmodel.dart';
// import 'package:tenkoyoho2/widgets/buildin_transform.dart';
import 'package:tenkoyoho2/widget/navigation_drawer.dart';
import 'package:tenkoyoho2/widget/single_weather_indo.dart';
// import 'package:tenkoyoho2/widget/single_weather.dart';
import 'package:tenkoyoho2/widget/single_weather_world.dart';
import 'package:tenkoyoho2/widget/slider_dot.dart';

class WeatherIndoScreen extends StatefulWidget {
  const WeatherIndoScreen({Key? key}) : super(key: key);
  static const String route = '/weather_indo';

  @override
  State<WeatherIndoScreen> createState() => _WeatherIndoScreenState();
}

class _WeatherIndoScreenState extends State<WeatherIndoScreen> {
  int _currentPage = 0;
  String bgImg = 'assets/sunny.jpg';
  bool add = true;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void didChangeDependencies() {
    if (add) {
      super.didChangeDependencies();
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) {
          Provider.of<WeatherIndoViewModel>(context, listen: false)
              .getAllWeathers();
        },
      );
      add = false;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final WeatherIndoViewModel weatherViewModel =
        Provider.of<WeatherIndoViewModel>(context);
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
    String? wT =
        weatherViewModel.weathers[_currentPage].data![0].weather?.description;
    print('This is wT: $wT');

    // print('This is bgImg: $bgImg');
    List<Map> weatherTypes = StaticData.weatherTypes;
    // print('This is weatherTypes: ${weatherTypes.length}');
    for (int i = 0; i < weatherTypes.length; i++) {
      // print(weatherTypes[i]['weatherType']);
      // print(wT);
      print('$wT = ${weatherTypes[i]['weatherType']}');
      if (weatherTypes[i]['weatherType'] == wT) {
        // print(
        //     'This is weatherTypes[i][\'weatherType\']: ${weatherTypes[i]['weatherType']}');
        bgImg = weatherTypes[i]['bg'];
        print('This is bgImg: $bgImg');
        break;
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
                // 'assets/ModerateRain.jpg',
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
                          index < weatherViewModel.weathers.length;
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
              itemCount: weatherViewModel.weathers.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return SingleWeatherIndoWidget(
                  index: index,
                );
              },
            ),
            // TransformerPageView(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: weatherLocations.length,
            //   transformer: ScaleAndFadeTransformer(),
            //   viewportFraction: 0.8,
            //   onPageChanged: _onPageChanged,
            //   itemBuilder: (context, index) {
            //     return SingleWeatherWidget(
            //       index: index,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
