import 'package:climate_app/screens/city_screen.dart';
import 'package:climate_app/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climate_app/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late int condition;
  late String cityName;
  late String Weathericon;
  late String WeatherMssg;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateUI(widget.locationWeather);
  }

  void UpdateUI(var weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temperature = 0;
        Weathericon = "Error";
        WeatherMssg = "Unable to get weather data";
        cityName = "";
        return;
      }
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      condition = weatherdata['weather'][0]['id'];
      cityName = weatherdata['name'];
      Weathericon = weather.getWeatherIcon(condition);
      WeatherMssg = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      UpdateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      var typed_name=await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if(typed_name!=null)
                        {
                          var weatherData=await weather.getCityWeather(typed_name);
                          UpdateUI(weatherData);
                        }

                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      Weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$WeatherMssg in $cityName",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
