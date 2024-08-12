import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/fectures/weather/data/models/weather_model.dart';

class WeatherInfoScreen extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherInfoScreen({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Info'),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  weatherModel.name ?? '-',
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  '${(weatherModel.main?.temp ?? 0).toInt() - 273} °C',
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  dateConvertor(weatherModel.dt),
                  style: TextStyle(fontSize: 40),
                ),
                Image.network(
                  'https://openweathermap.org/img/wn/${weatherModel.weather?.first.icon}@4x.png',
                  height: 400,
                  width: 400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String dateConvertor(int? date) {
  if (date != null) {
    var dt = DateTime.fromMillisecondsSinceEpoch(date * 1000);

    var d12 =
        DateFormat('MM/dd/yyyy, hh:mm a').format(dt); // 12/31/2000, 10:00 PM

    var d24 = DateFormat('dd:MM:yyyy, HH:mm').format(dt); // 31/12/2000, 22:00

    return d24;
  } else {
    return '-';
  }
}
