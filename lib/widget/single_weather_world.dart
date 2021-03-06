import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tenkoyoho2/screen/weather_detail/weather_detail_screen.dart';
import 'package:tenkoyoho2/screen/weather_world/weather_world_viewmodel.dart';

// ignore: must_be_immutable
class SingleWeatherWorldWidget extends StatelessWidget {
  int index;
  SingleWeatherWorldWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherWorldViewModel weatherViewModel =
        Provider.of<WeatherWorldViewModel>(context);
    // double? barHumidity =
    //     weatherViewModel.weathers[index].data![0].rh?.toDouble();
    // barHumidity = (barHumidity! / 2);
    // double? barCloud =
    //     weatherViewModel.weathers[index].data![0].cloudsMid?.toDouble();
    // barCloud = (barCloud! / 2);
    // ignore: avoid_unnecessary_containers
    double? widthWindSpd = 0;
    if (weatherViewModel.weathers[index].data![0].windSpd > 0) {
      widthWindSpd =
          weatherViewModel.weathers[index].data![0].windSpd.toDouble();
      if (widthWindSpd! > 50) {
        widthWindSpd = 50;
      }
    }
    double? widthHumidity = 0;
    if (weatherViewModel.weathers[index].data![0].rh! > 0) {
      widthHumidity = weatherViewModel.weathers[index].data![0].rh!.toDouble();
      if (widthHumidity > 50) {
        widthHumidity = 50;
      }
    }
    double? widthVis = 0;
    if (weatherViewModel.weathers[index].data![0].vis! > 0) {
      widthVis = weatherViewModel.weathers[index].data![0].vis!.toDouble();
      if (widthVis! > 50) {
        widthVis = 50;
      }
    }
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
                      '${weatherViewModel.weathers[index].cityName}',
                      style: GoogleFonts.lato(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${weatherViewModel.weathers[index].countryCode} ${weatherViewModel.weathers[index].timezone}',
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
                      '${weatherViewModel.weathers[index].data![0].validDate}',
                      style: GoogleFonts.lato(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${weatherViewModel.weathers[index].data![0].temp}??',
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
                              'https://www.weatherbit.io/static/img/icons/${weatherViewModel.weathers[index].data![0].weather!.icon}.png',
                              height: 30,
                              width: 30,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${weatherViewModel.weathers[index].data![0].weather!.description}',
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
                            Navigator.pushNamed(
                              context,
                              WeatherDetailScreen.route,
                              arguments: weatherViewModel.weathers[index],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Text(
                                  'Details',
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
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
                                  size: 12,
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
                          '${weatherViewModel.weathers[index].data![0].windSpd}',
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
                          '${weatherViewModel.weathers[index].data![0].rh}',
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
                          '${weatherViewModel.weathers[index].data![0].vis}',
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
    );
  }
}
