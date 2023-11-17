import 'Networkhelper.dart';
import 'package:climate_app/services/location.dart';



class WeatherModel {
  double lat=0,lon=0;
  String APIKEY = "a625a6caec05760d9eac3485ca541d27";
  Future<dynamic> getLocationWeather() async
  {
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitutde;
    lon = location.longitude;
    String url="https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$APIKEY&units=metric";
    NetworkHelper networkHelper=NetworkHelper(url);
    var weatherdata=await networkHelper.getData();
    return weatherdata;
  }

  Future<dynamic> getCityWeather(String cityName) async
  {
    String url="https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$APIKEY&units=metric";
    NetworkHelper networkHelper=NetworkHelper(url);
    var weatherdata=await networkHelper.getData();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
