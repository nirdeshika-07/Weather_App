class WeatherModel{
  final double currentTemp;
  final String currentSky;
  final double currentPressure;
  final double currentWindSpeed;
  final double currentHumidity;
  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
  });
  // WeatherModel copyWith({
  //   double? currentTemp,
  //   String? currentSky,
  //   double? currentPressure,
  //   double? currentWindSpeed,
  //   double? currentHumidity,
  // }){
  //   return WeatherModel(
  //       currentTemp: currentTemp ?? this.currentTemp,
  //       currentSky: currentSky ?? this.currentSky,
  //       currentPressure: currentPressure ?? this.currentPressure,
  //       currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
  //       currentHumidity: currentHumidity ?? this.currentHumidity
  //   );
  // }
  factory WeatherModel.fromMap(Map<String, dynamic> map){
    final currentWeatherData = map['list'][0];

    return WeatherModel(
        currentTemp: (currentWeatherData['main']['temp'] as num) .toDouble(),
        currentSky: (currentWeatherData['weather'][0]['main'] as String) .toString(),
        currentPressure: (currentWeatherData['main']['pressure'] as num) .toDouble(),
        currentWindSpeed: (currentWeatherData['wind']['speed'] as num) .toDouble(),
        currentHumidity: (currentWeatherData['main']['humidity'] as num) .toDouble()
    );
  }
  // final hourlyForecast = data['list'][index + 1];
  // final hourlySky = data['list'][index + 1]['weather'][0]['main'];
  // final hourlyTemp = hourlyForecast['main']['temp'].toString();
}