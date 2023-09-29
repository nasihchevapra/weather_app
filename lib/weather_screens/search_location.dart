import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_s/view_model/theme_provider.dart';
import 'package:weather_s/view_model/weather_provider.dart';
import 'package:weather_s/widgets/imgae_wid.dart';

class SearchLocation extends StatelessWidget {
  SearchLocation({super.key});
  final locatincontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigt = MediaQuery.of(context).size.height;
    final weatherP = Provider.of<WeatherProvider>(context);
    final themeP = Provider.of<ThemeProvider>(context);
    final weatherModel = weatherP.weatherModel;
    return Scaffold(
      backgroundColor: themeP.light1 == true
          ? Colors.black
          : const Color.fromARGB(255, 16, 25, 37),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              width: screenWidth * 1,
              height: screenheigt * 0.40,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                      TextField(
                        controller: locatincontroller,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelStyle: const TextStyle(color: Colors.white),
                            suffix: IconButton(
                                onPressed: () {
                                  weatherP.fetchWeather(
                                      city: locatincontroller.text,
                                      context: context);
                                },
                                icon: const Icon(
                                  Icons.search,
                                  size: 25,
                                  color: Colors.white,
                                )),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              width: 0.1,
                              color: Colors.white,
                            )),
                            hintText: 'Search Location',
                            hintStyle: const TextStyle(color: Colors.white),
                            constraints: BoxConstraints(
                                maxWidth: screenWidth * 0.70,
                                maxHeight: screenheigt * 0.040)),
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: screenWidth * 0.4,
                          height: screenheigt * 0.1,
                          child: weatherModel != null
                              ? getImageWidget(
                                  weatherModel.weather[0].description)
                              : Image.asset('assets/s2.webp')),
                      Column(
                        children: [
                          weatherP.indCircular == true
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 5,
                                  backgroundColor: Colors.black,
                                )
                              : Text(
                                  weatherModel != null
                                      ? '${weatherModel.main.temp}°C'
                                      : '0°C',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Lilli',
                                    shadows: [
                                      Shadow(
                                          color: themeP.light1 == true
                                              ? Colors.black
                                              : Colors.blue,
                                          blurRadius: 2,
                                          offset: const Offset(5, 5))
                                    ],
                                  ),
                                ),
                          Text(
                            weatherModel != null
                                ? weatherModel.weather[0].description
                                : '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Lilli'),
                          ),
                          Text(
                            weatherModel != null
                                ? '${weatherModel.name}\t|\t|${weatherModel.sys.country}'
                                : '',
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Lilli'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            weatherModel != null
                                ? 'tempM: ${weatherModel.main.tempMin}°C'
                                : 'tempM: 0°C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Lilli'),
                          ),
                          Text(
                            weatherModel != null
                                ? 'tempMax: ${weatherModel.main.tempMax}°C'
                                : 'tempM: 0°C',
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
                            weatherModel != null
                                ? '${weatherModel.wind.speed}km/hr\n${weatherModel.wind.deg}deg'
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
                            weatherModel != null
                                ? '${weatherModel.main.feelsLike}°C'
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
                            weatherModel != null
                                ? '${weatherModel.main.pressure}°C'
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
                            weatherModel != null
                                ? '${weatherModel.main.humidity}°C'
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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Recent Search History',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Lilli')),
                  IconButton(
                      onPressed: () {
                        weatherP.removieShare();
                      },
                      icon: const Icon(
                        Icons.delete_sweep_outlined,
                        color: Colors.white,
                        size: 30,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: SizedBox(
                width: screenWidth * 1,
                child: Consumer<WeatherProvider>(builder: (context, cr, c) {
                  return ListView.separated(
                    reverse: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    separatorBuilder: (context, index) {
                      return const Padding(padding: EdgeInsets.only(top: 20));
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: cr.cityList.length,
                    padding: const EdgeInsets.only(top: 0, bottom: 12),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        width: screenWidth * 0.92,
                        height: screenheigt * 0.15,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 16, 25, 37),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue,
                              spreadRadius: 2.0,
                              offset: Offset(1, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        foregroundDecoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      ' ${cr.cityList[index]}\t|',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Lilli'),
                                    ),
                                    Text(
                                      ' \t${cr.countryList[index]}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Lilli'),
                                    ),
                                  ],
                                ),
                                Text(cr.descriptionList[index],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Lilli')),
                                Text(cr.dateList[index],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Lilli')),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: screenWidth * 0.090,
                                    height: screenheigt * 0.090,
                                    child: getImageWidget(
                                        weatherP.descriptionList[index])),
                                Text('${cr.weatherList[index]}°C'.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Lilli'))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
