import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:weather/weather.dart';
import 'package:weather_app/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(apiKey);
  TextEditingController cityController = TextEditingController();
  Weather? _weather;
  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Peshawar").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _weather == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      child: ListTile(
                        title: TextField(
                            controller: cityController,
                            decoration: InputDecoration(
                                suffixIcon: TextButton(
                                    child: const Icon(
                                      Icons.search,
                                    ),
                                    onPressed: () async {
                                      try {
                                        Weather weather =
                                            await _wf.currentWeatherByCityName(
                                                cityController.text);
                                        // print(weather.areaName);
                                        setState(() {
                                          _weather = weather;
                                        });
                                      } catch (e) {
                                        var snackBar = SnackBar(
                                            content: Text(
                                                "\"${cityController.text}\" city does not exit"));
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    })),
                            onSubmitted: (v) async {
                              try {
                                Weather weather =
                                    await _wf.currentWeatherByCityName(v);
                                // print(weather.areaName);
                                setState(() {
                                  _weather = weather;
                                });
                              } catch (e) {
                                var snackBar = SnackBar(
                                    content: Text("\"$v\" city does not exit"));
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            }),
                      ),
                    ),
                    Text(
                      _weather!.areaName ?? "",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.08,
                    ),
                    _dateTime(),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                    ),
                    _weatherIcon(),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    _currentTemp(),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    _extraInfo()
                  ],
                ),
              ));
  }

  Widget _dateTime() {
    DateTime now = _weather?.date ?? DateTime.now();
    return Column(
      children: [
        Text(DateFormat("hh:mm a").format(now),
            style: const TextStyle(fontSize: 35)),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(" ${DateFormat("d.m.y").format(now)}",
                style: const TextStyle(fontWeight: FontWeight.w400)),
          ],
        )
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(color: Colors.black, fontSize: 20),
        )
      ],
    );
  }

  Widget _currentTemp() {
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
        style: const TextStyle(fontSize: 90, fontWeight: FontWeight.w600));
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300)),
              Text("Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300)),
              Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300))
            ],
          )
        ],
      ),
    );
  }
}
