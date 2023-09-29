import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_s/view_model/theme_provider.dart';
import 'package:weather_s/view_model/weather_provider.dart';
import 'package:weather_s/weather_screens/seel_all_data.dart';
import 'package:weather_s/weather_screens/search_location.dart';
import 'package:weather_s/widgets/imgae_wid.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigt = MediaQuery.of(context).size.height;
    final weathePdd = Provider.of<WeatherProvider>(context, listen: false);
    final themeP = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeP.light1 == true
          ? Colors.black
          : const Color.fromARGB(255, 16, 25, 37),
      body: Consumer<WeatherProvider>(builder: (context, weatherp, c) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              width: screenWidth * 1,
              height: screenheigt * 0.78,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 28, 60, 87),
                    spreadRadius: 2.0,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
                gradient: LinearGradient(
                  colors: [
                    themeP.light1 == true
                        ? const Color.fromARGB(255, 16, 25, 37)
                        : const Color.fromARGB(255, 135, 200, 253),
                    themeP.light1 == true
                        ? const Color.fromARGB(255, 16, 25, 37)
                        : const Color.fromARGB(255, 33, 148, 243),
                    themeP.light1 == true
                        ? const Color.fromARGB(255, 16, 25, 37)
                        : const Color.fromARGB(255, 10, 165, 255),
                    themeP.light1 == true
                        ? const Color.fromARGB(255, 16, 25, 37)
                        : Colors.blue.shade500,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              foregroundDecoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //  crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Switch(
                        thumbIcon: MaterialStatePropertyAll(
                            themeP.light1 == true
                                ? const Icon(Icons.nightlight)
                                : const Icon(Icons.sunny)),
                        activeTrackColor: Colors.blue,
                        inactiveTrackColor:
                            const Color.fromARGB(255, 16, 25, 37),
                        value: themeP.light1,
                        onChanged: (bool value) {
                          themeP.theme(value);
                        },
                      ),
                      TextButton.icon(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.blue,
                                title: const OurText(
                                    label: 'Get Current Location weather Data'),
                                content: const SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      OurText(
                                          label:
                                              'Also have Today Weather Data,It will be Change Tommorrow'),
                                      OurText(
                                          label: 'Would you like to Continue?')
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const OurText(label: 'Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const OurText(label: 'Continue?'),
                                    onPressed: () {
                                      weathePdd.fetchCurrentWeather().then(
                                          (value) =>
                                              Navigator.of(context).pop());
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        label: Consumer<WeatherProvider>(
                            builder: (context, weatherP, c) {
                          return Row(
                            children: [
                              Text(
                                weatherp.weatherModel != null
                                    ? '${weatherp.weatherModel!.name}\t'
                                    : 'City\t',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  //fontFamily: 'Lilli'
                                ),
                              ),
                              Text(
                                weatherp.weatherModel != null
                                    ? '|\t${weatherp.weatherModel!.sys.country}'
                                    : '|\tIN',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  //fontFamily: 'Lilli'
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.3)
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: screenWidth * 2,
                      height: screenheigt * 0.20,
                      child: weatherp.weatherModel != null
                          ? getImageWidget(
                              weatherp.weatherModel!.weather[0].description)
                          : Image.asset('assets/s2.webp')),
                  Column(
                    children: [
                      weatherp.indCircular == true
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 5,
                              backgroundColor: Colors.black,
                            )
                          : Text(
                              weatherp.weatherModel != null
                                  ? '${weatherp.weatherModel!.main.temp}°C'
                                  : '0°C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 90,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Lilli',
                                shadows: [
                                  Shadow(
                                      color: themeP.light1 == true
                                          ? Colors.black
                                          : Colors.blue,
                                      blurRadius: 2,
                                      offset: const Offset(10, 10))
                                ],
                              ),
                            ),
                      Column(
                        children: [
                          Text(
                            weatherp.weatherModel != null
                                ? 'tempM: ${weatherp.weatherModel!.main.tempMax}°C'
                                : 'tempM: 0°C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Lilli'),
                          ),
                          Text(
                            weatherp.weatherModel != null
                                ? 'tempMax: ${weatherp.weatherModel!.main.tempMin}°C'
                                : 'tempM: 0°C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Lilli'),
                          ),
                        ],
                      ),
                      Text(
                        weatherp.weatherModel != null
                            ? weatherp.weatherModel!.weather[0].description
                            : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Lilli',
                        ),
                      ),
                      Text(
                        weatherp.weatherModel != null
                            ? weatherp.weatherModel!.weather[0].main
                            : '',
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'Lilli'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.wind_power,
                            color: Colors.white,
                          ),
                          const Text(
                            'Wind',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Lilli'),
                          ),
                          Text(
                            weatherp.weatherModel != null
                                ? '${weatherp.weatherModel!.wind.speed}km/hr\n${weatherp.weatherModel!.wind.deg}deg'
                                : '0km/hr',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Lilli'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.accessibility_new,
                            color: Colors.white,
                          ),
                          const Text(
                            'Feels like',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Lilli'),
                          ),
                          Text(
                            weatherp.weatherModel != null
                                ? '${weatherp.weatherModel!.main.feelsLike}°C'
                                : '0°C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Lilli'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.air_sharp,
                            color: Colors.white,
                          ),
                          const Text(
                            'Pressure',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Lilli'),
                          ),
                          Text(
                            weatherp.weatherModel != null
                                ? '${weatherp.weatherModel!.main.pressure}°C'
                                : '0°C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Lilli'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.hub,
                            color: Colors.white,
                          ),
                          const Text(
                            'Humidity',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Lilli'),
                          ),
                          Text(
                            weatherp.weatherModel != null
                                ? '${weatherp.weatherModel!.main.humidity}°C'
                                : '0°C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Lilli'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenheigt * 0.03,
            ),
            TextButton.icon(
                style: const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Colors.blue),
                    iconColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SeeAllData(),
                      ));
                },
                icon: const Icon(Icons.arrow_forward_ios_outlined),
                label: const Text(
                  'See All Weather Data',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                )),
            SizedBox(
              height: screenheigt * 0.01,
            ),
            TextButton.icon(
                style: const ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Colors.blue),
                    iconColor: MaterialStatePropertyAll(Colors.white)),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return SearchLocation();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var tween = Tween(
                                begin: const Offset(0.0, 10), end: Offset.zero)
                            .chain(CurveTween(curve: Curves.linearToEaseOut));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text(
                  'Search Location Based Weather',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                )),
          ],
        );
      }),
    );
  }
}
