class WeatherModel {
  final String cityName;
  final String countryName;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weatherCondition;
  final String weatherIcon;
  final DateTime date;
  WeatherModel({
    required this.cityName,
    required this.countryName,
    required this.temp,
    required this.weatherCondition,
    required this.weatherIcon,
    required this.tempMin,
    required this.tempMax,
    required this.date,
  });

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      cityName: json["location"]["name"],
      countryName: json["location"]["country"],
      temp: json["forecast"]["forecastday"][0]["day"]["avgtemp_c"],
      tempMin: json["forecast"]["forecastday"][0]["day"]["mintemp_c"],
      tempMax: json["forecast"]["forecastday"][0]["day"]["maxtemp_c"],
      weatherCondition: json["forecast"]["forecastday"][0]["day"]["condition"]
          ["text"],
      weatherIcon: json["forecast"]["forecastday"][0]["day"]["condition"]
          ["icon"],
      date: DateTime.parse(json["current"]["last_updated"]),
    );
  }

  // String get minTemp => tempMin.toInt().toString();

  // String get maxTemp => tempMax.toInt().toString();
}
