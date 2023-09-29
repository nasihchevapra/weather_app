import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_s/model/weather_model.dart';

abstract class WeatherClass extends ChangeNotifier {
  String apiID = 'http://api.openweathermap.org/data/2.5/weather';
  String apiKey = dotenv.env['API_KEY'].toString();
  WeatherData? weatherModel;
  String mydate = DateFormat('EEE, M/d/y hh:mm a').format(DateTime.now());
  String saveDate = DateFormat('M/d/y').format(DateTime.now());
  bool indCircular = false;
  bool internetConnection = false;
  late Timer timer;
  List<String> cityList = [];
  List<String> countryList = [];
  List<String> weatherList = [];
  List<String> descriptionList = [];
  List<WeatherData> recentSearches = [];
  List<String> dateList = [];
  fetchWeather({required String city, required BuildContext context});
  fetchCurrentWeather();
}

class WeatherProvider extends WeatherClass {
  WeatherProvider() {
    // fetchCurrentWeather();
    getListdatass();
    checkinShared();
  }

  void getListdatass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cityList = (prefs.getStringList('CL') ?? []);
    countryList = (prefs.getStringList('CW') ?? []);
    weatherList = (prefs.getStringList('WL') ?? []);
    descriptionList = (prefs.getStringList('DL') ?? []);
    dateList = (prefs.getStringList('DTL') ?? []);
    notifyListeners();
  }

  void removieShare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    cityList.clear();
    countryList.clear();
    descriptionList.clear();
    weatherList.clear();
    notifyListeners();
  }

  @override
  Future<void> fetchWeather(
      {required String city, required BuildContext context}) async {
    indCircular = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('$apiID?q=$city&appid=$apiKey&units=metric'),
    );
    if (response.statusCode == 200) {
      final jsonWeatherData = await json.decode(response.body);
      weatherModel = WeatherData.fromJson(jsonWeatherData);
      saveList();
      notifyListeners();
      indCircular = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Failed to fetch weather data',
              style: TextStyle(color: Colors.white),
            )),
      );
      print('Failed to fetch weather data');
      indCircular = false;
    }
    notifyListeners();
  }

  saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cityList.add(weatherModel!.name);
    countryList.add(weatherModel!.sys.country);
    descriptionList.add(weatherModel!.weather[0].description);
    weatherList.add(weatherModel!.main.temp.toString());
    dateList.add(mydate);
    prefs.setStringList('CL', cityList);
    prefs.setStringList('CW', countryList);
    prefs.setStringList('DL', descriptionList);
    prefs.setStringList('WL', weatherList);
    prefs.setStringList('DTL', dateList);
    notifyListeners();
  }

  Future<Position> determinePosition() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          indCircular = false;
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        indCircular = false;
        // Permissions are denied forever, handle appropriately.
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } on LocationServiceDisabledException catch (e) {
      print('$e');
      indCircular = false;
      return Future.error('Location  permissions$e.');
    }
  }

  void checkInternetCunnection() async {
    try {
      final connection = await InternetAddress.lookup('google.com');
      if (connection.isNotEmpty && connection[0].rawAddress.isNotEmpty) {
        internetConnection = true;
      }
    } on SocketException catch (e) {
      print(e);
    }
  }

  void checkinShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String saveddate = prefs.getString('saveDate') ?? '';
    if (saveddate == saveDate) {
      savedsharedatas();
    } else {
      fetchCurrentWeather();
    }
  }

  @override
  Future<void> fetchCurrentWeather() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    indCircular = true;
    notifyListeners();
    Position position = await determinePosition();
    double? latitude = position.latitude;
    double? longitude = position.longitude;

    final response = await http.get(
      Uri.parse(
        '$apiID?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
      ),
    );
    if (response.statusCode == 200) {
      final jsonWeatherData = await json.decode(response.body);
      weatherModel = WeatherData.fromJson(jsonWeatherData);
      prefs.setString('weatherdata', json.encode(jsonWeatherData));
      prefs.setString('saveDate', saveDate);
      indCircular = false;
      notifyListeners();
    } else {
      print('Failed to fetch weather data');
      indCircular = false;
      notifyListeners();
    }
    notifyListeners();
  }

  void savedsharedatas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsondatas = await jsonDecode(prefs.getString('weatherdata')!);
    weatherModel = WeatherData.fromJson(jsondatas);
    notifyListeners();
  }
}
