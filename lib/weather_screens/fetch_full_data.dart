import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_s/view_model/weather_provider.dart';
import 'package:weather_s/widgets/imgae_wid.dart';

class SeeAllData extends StatelessWidget {
  const SeeAllData({super.key});

  @override
  Widget build(BuildContext context) {
    final weatheP = Provider.of<WeatherProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 25, 37),
      body: SafeArea(
        child: Center(
            child: weatheP.weatherModel == null
                ? const OurText(label: 'Data Not Found')
                : Column(
                    children: [
                      OurText(
                          label:
                              '${weatheP.weatherModel!.name}\t|\t${weatheP.weatherModel!.sys.country}'),
                      OurText(label: 'temp:${weatheP.weatherModel!.main.temp}'),
                      OurText(label: 'id: ${weatheP.weatherModel!.sys.id}'),
                      OurText(
                          label:
                              'sunrise: ${weatheP.weatherModel!.sys.sunrise}'),
                      OurText(
                          label: 'sunset :${weatheP.weatherModel!.sys.sunset}'),
                      OurText(label: 'type :${weatheP.weatherModel!.sys.type}'),
                      OurText(label: 'base :${weatheP.weatherModel!.base}'),
                      OurText(
                          label: 'all :${weatheP.weatherModel!.clouds.all}'),
                      OurText(label: 'cod :${weatheP.weatherModel!.cod}'),
                      OurText(
                          label:
                              'latitude :${weatheP.weatherModel!.coord.lat}'),
                      OurText(
                          label:
                              'longtitude :${weatheP.weatherModel!.coord.lon}'),
                      OurText(label: 'dt :${weatheP.weatherModel!.dt}'),
                      OurText(label: 'id2 :${weatheP.weatherModel!.id}'),
                      OurText(
                          label:
                              'feelsLike: ${weatheP.weatherModel!.main.feelsLike}'),
                      OurText(
                          label:
                              'humidity :${weatheP.weatherModel!.main.humidity}'),
                      OurText(
                          label:
                              'pressure :${weatheP.weatherModel!.main.pressure}'),
                      OurText(
                          label:
                              'tempMax :${weatheP.weatherModel!.main.tempMax}'),
                      OurText(
                          label:
                              'tempMin :${weatheP.weatherModel!.main.tempMin}'),
                      OurText(
                          label: 'tempmax :${weatheP.weatherModel!.timezone}'),
                      OurText(
                          label:
                              'Visibility :${weatheP.weatherModel!.visibility}'),
                      OurText(
                          label:
                              'Wind Speed :${weatheP.weatherModel!.wind.speed}'),
                      OurText(
                          label: 'Wind deg :${weatheP.weatherModel!.wind.deg}'),
                      OurText(
                          label:
                              'Weatherdescription :${weatheP.weatherModel!.weather.first.description}'),
                      OurText(
                          label:
                              'Icon :${weatheP.weatherModel!.weather.first.icon}'),
                      OurText(
                          label:
                              'ID :${weatheP.weatherModel!.weather.first.id}'),
                      OurText(
                          label:
                              'Main :${weatheP.weatherModel!.weather.first.main}'),
                    ],
                  )),
      ),
    );
  }
}
