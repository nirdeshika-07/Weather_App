part of 'weather_bloc.dart';

sealed class WeatherState{}

final class WeatherInitial extends WeatherState{}
final class WeatherSuccess extends WeatherState{
  final WeatherModel weatherModel;
  final  List<Map<String, dynamic>> hourlyForecast;

  WeatherSuccess({
    required this.weatherModel,
    required this.hourlyForecast,
  });
}
final class WeatherFailure extends WeatherState{
  final String error;
  WeatherFailure(this.error);
}
final class WeatherLoading extends WeatherState{}