//All the CRUD from APIs
// import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class WeatherDataProvider{
  Future<String> getCurrentWeather(String cityName) async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=${dotenv.env['OPEN_WEATHER_API_KEY']}',
        ),
      );
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}