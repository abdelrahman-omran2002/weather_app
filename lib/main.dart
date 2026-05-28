import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          // هنجيب حالة الطقس الحالية
          String? condition = BlocProvider.of<GetWeatherCubit>(context)
              .weatherModel
              ?.weatherCondition;

          return MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: getThemeColor(condition),
                primary: getThemeColor(condition),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: getThemeColor(condition),
                foregroundColor: Colors.white,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}

MaterialColor getThemeColor(String? weatherCondition) {
  if (weatherCondition == null) {
    return Colors.orange;
  }

  String condition = weatherCondition.toLowerCase();

  String simplifiedCondition = "orange";

  if (condition.contains("cloud") ||
      condition.contains("overcast") ||
      condition.contains("mist") ||
      condition.contains("fog")) {
    simplifiedCondition = "cloud";
  } else if (condition.contains("rain") ||
      condition.contains("drizzle") ||
      condition.contains("shower") ||
      condition.contains("thunder")) {
    simplifiedCondition = "rain";
  } else if (condition.contains("clear") || condition.contains("sunny")) {
    simplifiedCondition = "clear";
  } else if (condition.contains("snow") ||
      condition.contains("sleet") ||
      condition.contains("ice")) {
    simplifiedCondition = "snow";
  }

  switch (simplifiedCondition) {
    case "cloud":
      return Colors.grey;
    case "rain":
      return Colors.blue;
    case "clear":
      return Colors.orange;
    case "snow":
      return Colors.blue;
    default:
      return Colors.orange;
  }
}
