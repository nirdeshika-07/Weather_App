import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/model/hourly_forecast_model.dart';

import '../reusable/aditional_info_item.dart';
import '../reusable/hourly_forecast_item.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.title});
  final String title;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override
  void initState() {
    super.initState();
    context.read <WeatherBloc>().add(WeatherFetched());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(128, 127, 132, 1),
        title: Text(
          widget.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       // setState(() {
      //       //   weather = getCurrentWeather();
      //       // });
      //       context.read<WeatherBloc>().add(WeatherFetched());
      //     },
      //     icon: const Icon(Icons.refresh),
      //   ),
      // ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          // context.read<WeatherBloc>().add(WeatherFetched());
          final bloc = context.read<WeatherBloc>();
          if(bloc.state is! WeatherLoading){
            bloc.add(WeatherFetched());
          }
        },
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(
            //     child: CircularProgressIndicator.adaptive(),
            //   );
            // }
            //
            // if (snapshot.hasError) {
            //   return Center(
            //     child: Text(snapshot.error.toString()),
            //   );
            // }

            if(state is WeatherFailure){
              return Center(
                child: Text(state.error),
              );
            }
            if(state is WeatherLoading){
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if(state is WeatherSuccess){
              final data = state.weatherModel;
              final  List<Map<String, dynamic>> hourlyForecastList = state.hourlyForecast;

              final currentTemp = data.currentTemp;
              final currentSky = data.currentSky;
              final currentPressure = data.currentPressure;
              final currentWindSpeed = data.currentWindSpeed;
              final currentHumidity = data.currentHumidity;

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Text(
                                      '$currentTemp K',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Icon(
                                      currentSky == 'Clouds' || currentSky == 'Rain'
                                          ? Icons.cloud
                                          : Icons.sunny,
                                      size: 64,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      currentSky,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Hourly Forecast',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 120,
                        child:
                        ListView.builder(
                          // itemCount: hourlyForecastList.length-1,
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final hourlyForecast = hourlyForecastList[index+1];

                            final hourlyForecastModel = HourlyForecastModel.fromMap(hourlyForecast);
                            final hourlyTemp = hourlyForecastModel.hourlyTemp;
                            final hourlySky = hourlyForecastModel.hourlySky;
                            final time = hourlyForecastModel.hourlyTime;

                            return HourlyForecastItem(
                              time: DateFormat.j().format(time),
                              temperature: hourlyTemp.toString(),
                              icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        'Additional Information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AdditionalInfoItem(
                            icon: Icons.water_drop,
                            label: 'Humidity',
                            value: currentHumidity.toString(),
                          ),
                          AdditionalInfoItem(
                            icon: Icons.air,
                            label: 'Wind Speed',
                            value: currentWindSpeed.toString(),
                          ),
                          AdditionalInfoItem(
                            icon: Icons.beach_access,
                            label: 'Pressure',
                            value: currentPressure.toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView(
              children: [
                SizedBox(height: 300,),
                Center(child: CircularProgressIndicator(),),
              ],
            );
          },
        ),
      ),
    );
  }
}