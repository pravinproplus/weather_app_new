import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Network/GetWeather.dart';
import 'package:weather_app/Screens/HomeScreen.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var data;
  late WeatherFactory ws;
  List forecast = [];
  //Get week weather data
  Future getWetherWeek() async {
    ws = new WeatherFactory(apiKey);
    try {
      forecast = await ws.fiveDayForecastByLocation(lat!, long!);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getWetherWeek();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView.separated(
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: forecast.isEmpty
                ? CircularProgressIndicator()
                : Text(forecast[index].toString()),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    ));
  }
}
