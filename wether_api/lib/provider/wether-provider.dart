import 'package:flutter/material.dart';
import 'package:wether_api/models/models.dart';

import '../helper/helper.dart';

class HomeProvider with ChangeNotifier {
  Wetherapimodel? model;
  WeatherModal2? model2;
  String? city;
  String? bookmarkcity;
  bool isFavorite = false;

  void getWeatherData(String search) async {
    WeatherHelper helper = WeatherHelper();
    model = await helper.getData(search);
    city = search;
    print("Fetching weather data for city: $search");

    notifyListeners();
  }

  void getWeather2Data(String search) async {
    if (city == null) return;

    WeatherHelper w = WeatherHelper();
    model2 = await w.getData2(search);

    print("Fetched data: ${model2?.l}");
    notifyListeners();
  }

  void addBookmark(String city) {
    bookmarkcity = city;
    notifyListeners();
  }
}
