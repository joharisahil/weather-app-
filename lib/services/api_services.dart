import 'dart:convert';
import 'package:demo_application/models/current_weather_model.dart';
import 'package:demo_application/models/hourly_weather_model.dart';
import 'package:demo_application/models/search_weather_model.dart';
import '../consts/strings.dart';
import 'package:http/http.dart' as http;

getCurrentWeather(lat, long) async {
  String link = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  try {
    var res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = currentWeatherDataFromJson(res.body.toString());
      return data;
    }
  } catch (error) {
    print("--> Something went wrong");
  }
}

getHourlyWeather(lat, long) async {
  var link = "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric";
  try {
    var res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = hourlyWeatherDataFromJson(res.body.toString());
      return data;
    }
  } catch (error) {
    print("-->Something went wrong ${error}");
  }
}

Future getNextDaysData(String lat, String lon) async {
  var link = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$lon&cnt=7&appid=$apiKey";
  try {
    http.Response res = await http.get(Uri.parse(link));
    print("-->");
    if (res.statusCode == 200) {
      print("--> success");
      var data = jsonDecode(res.body);
      print("--> ${data}");
    }
  } catch (error) {
    print("-->Something went wrong ${error}");
  }
}

getSearchCurrentWeather(String query) async {
  String link = "http://api.weatherstack.com/current?access_key=$searchWeatherApiKey&query=$query";
  try {
    http.Response res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var searchData = SearchWeatherModel.fromJson(data);
      return searchData;
    }
  } catch (error) {
    print("-->Something went wrong ${error}");
  }
}
