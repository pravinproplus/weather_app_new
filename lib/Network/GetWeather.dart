import 'package:weather/weather.dart';

//Weather Apikey
String apiKey = "99d92cc95a2292104c6595069ad89ce4";

class GetWeather {
  GetWeather({this.lat, this.lon});
  late WeatherFactory ws;
  DateTime? date;
  Temperature? maxtemp;
  Temperature? temperature;
  String? area;
  String? icon;
  double? lat;
  double? lon;

  //Get weather funciton
  Future getWeather() async {
    ws = new WeatherFactory(apiKey);
    try {
      Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
      date = weather.date;
      temperature = weather.temperature;
      maxtemp = weather.tempMax;
      area = weather.areaName;
      icon = weather.weatherIcon;
    } catch (e) {
      print(e);
    }
  }
}
