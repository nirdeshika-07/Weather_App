import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherRepository{
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository(this.weatherDataProvider); //Positional Argument
  String cityName = 'Nepal';
  Future<WeatherModel> getCurrentWeather() async {
    try {
      // WeatherDataProvider().getCurrentWeather(cityName);
      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
  Future<List<Map<String, dynamic>>> getHourlyWeatherList() async {
    try{
      final hourlyWeatherData = await weatherDataProvider.getCurrentWeather(cityName);
      final data = jsonDecode(hourlyWeatherData) as Map<String,dynamic>;
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      final List<dynamic> response = data ['list'];
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw e.toString();
    }
  }
}