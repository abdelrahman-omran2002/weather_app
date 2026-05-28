import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/views/search_view.dart';
import 'package:weather_app/widgets/no_weather_body.dart';
import 'package:weather_app/widgets/weather_info_body.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeatherCubit, WeatherState>(
      builder: (context, state) {
        String? weatherCondition;
        if (state is LoadedWeatherState) {
          weatherCondition = state.weatherModel.weatherCondition;
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: getThemeColor(weatherCondition),
            elevation: 0,
            title: const Text(
              'Weather App',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SearchView();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: state is WeatherInitialState
              ? const NoWeatherBody()
              : state is LoadedWeatherState
                  ? WeatherInfoBody(weatherModel: state.weatherModel)
                  : const Text("Something went wrong"),
        );
      },
    );
  }
}
