import 'package:demo_application/consts/strings.dart';
import 'package:demo_application/models/search_weather_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchWeatherModel? _searchWeatherModel = null;
  String cityName = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/weather/weather_back.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      cityName = "";
                      _searchWeatherModel = null;
                    });
                  },
                  onSubmitted: (value) async {
                    _searchWeatherModel = await getSearchCurrentWeather(value);
                    setState(() {
                      _searchWeatherModel;
                      cityName = value;
                    });
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Search By City",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _searchWeatherModel == null
                    ? Column(
                        children: const [
                          Text(
                            "Seach City",
                            style: TextStyle(fontSize: 21),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            "Tempreature of ${cityName} is ${_searchWeatherModel?.current?.temperature}$degree",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
