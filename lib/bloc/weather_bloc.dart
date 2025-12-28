import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/weather_repository.dart';
import 'package:weather_app/model/weather_model.dart';

part 'weather_state.dart';
part 'weather_event.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) :super(WeatherInitial()){
    on<WeatherFetched>(_getCurrentWeather);
  }
  void _getCurrentWeather (WeatherFetched event, Emitter<WeatherState> state) async{
    emit(WeatherLoading());
    try{
      final weather = await weatherRepository.getCurrentWeather();
      final hourlyForecast = await weatherRepository.getHourlyWeatherList();
      emit(WeatherSuccess(weatherModel: weather, hourlyForecast: hourlyForecast));
    }
    catch(e){
      emit(WeatherFailure(e.toString()));
    }
  }
}