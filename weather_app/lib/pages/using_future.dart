import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApiScreen extends StatefulWidget {
  const WeatherApiScreen({super.key});

  @override
  State<WeatherApiScreen> createState() => _WeatherApiScreenState();
}

class _WeatherApiScreenState extends State<WeatherApiScreen> {
  Future<Weather>? _futureWeather;
  TextEditingController cityController = TextEditingController();
  Future<Weather> fetchWeather(
      String cityName /*, BuildContext context*/) async {
    final String _uri =
        "https://api.openweather.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey";
    final response = await http.get(Uri.parse(_uri));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      // var snackBar = SnackBar(content: Text("This city does not exit"));
      // if (context.mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }
      throw Exception("City Not Found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff333333),
        child: Container(
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.white),
          child: Column(
            children: [
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a city name'),
                onSubmitted: (String v) {
                  setState(() {
                    _futureWeather = fetchWeather(v);
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              _futureWeather == null
                  ? Container()
                  : FutureBuilder(
                      future: _futureWeather,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          return Column(
                            children: [
                              Text(snapshot.data!.cityName),
                              Text(snapshot.data!.temperature.toString()),
                              Text(snapshot.data!.description),
                            ],
                          );
                        } else {
                          return const Text("No data Available");
                        }
                      })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  Weather(
      {required this.cityName,
      required this.temperature,
      required this.description});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'],
        description: json['weather'][0]['description']);
  }
}
