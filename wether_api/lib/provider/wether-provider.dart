import 'package:flutter/material.dart';
import 'package:wether_api/models/models.dart';

import '../helper/helper.dart';

class HomeProvider with ChangeNotifier {
  Wetherapimodel? model;
  Wetherapimodel2? model2;
  String? city;
  bool isFavorite = false;

  void getWeatherData(String search) async {
    WeatherHelper helper = WeatherHelper();
    model = await helper.getData(search);
    city = search;

    print("-----------------------------------$search");

    notifyListeners();
  }

  void getWeather2Data(String search) async {
    WeatherHelper w = WeatherHelper();
    model2 = await w.getData2(search);
    print(
        "-----------------------------Fetched data: $model2"); // Check if model2 has valid data
    notifyListeners();
  }
}
