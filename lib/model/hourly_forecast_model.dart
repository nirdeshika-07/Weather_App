class HourlyForecastModel {
  final DateTime hourlyTime;
  final double hourlyTemp;
  final String hourlySky;

  HourlyForecastModel({
    required this.hourlyTime,
    required this.hourlyTemp,
    required this.hourlySky,
  });

  factory HourlyForecastModel.fromMap(Map<String, dynamic> map) {
    return HourlyForecastModel(
      hourlyTime: DateTime.parse(map['dt_txt']),
      hourlyTemp: (map['main']['temp'] as num).toDouble(),
      hourlySky: map['weather'][0]['main'],
    );
  }
}
