import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Network/GetWeather.dart';
import 'package:weather_app/Network/Location.dart';
import 'package:weather_app/Screens/WeatherScreen.dart';

double? lat;
double? long;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? date;
  Temperature? maxtemp;
  bool tr = false;
  Temperature? temperature;
  String? icon;
  String? area;
  String? urls;
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  Future getLocation() async {
    GPSLocation gpslocation = GPSLocation();
    await gpslocation.getLocationData();
    setState(() {
      lat = gpslocation.latitude;
      long = gpslocation.longtitude;
    });
    getWeatherData();
    print(lat);
  }

  Future getWeatherData() async {
    GetWeather getWeather = GetWeather(lat: lat, lon: long);
    await getWeather.getWeather();
    setState(() {
      area = getWeather.area;
      date = getWeather.date;
      maxtemp = getWeather.maxtemp;
      temperature = getWeather.temperature;
      icon = getWeather.icon;
      urls = 'http://openweathermap.org/img/wn/$icon@2x.png';
    });
  }

  Widget displayIcon() {
    return InkWell(
      child: Image.network(
        urls!,
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WeatherScreen()));
      },
    );

    //  Container(
    //   height: 50.0,
    //   width: 50.0,
    //   decoration: BoxDecoration(
    //     color: Colors.grey[350],
    //     borderRadius: BorderRadius.circular(20.0),
    //   ),
    //   child:
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        height: 500.0,
        width: 500.0,
        child: Stack(
          children: [
            Positioned(
              top: 80.0,
              left: 10.0,
              child: Text(
                "Area:\n$area",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Positioned(
              top: 80,
              left: 180.0,
              child: Text(
                "Date & Time:\n$date",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Positioned(
              top: 200.0,
              left: 10.0,
              child: Text(
                "Temperature:\n$temperature",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            urls == null
                ? Positioned(
                    top: 400.0,
                    left: 150.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Positioned(
                    top: 180.0,
                    left: 200.0,
                    child: displayIcon(),
                  ),
          ],
        ),
      ),
    );
  }
}
