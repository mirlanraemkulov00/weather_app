import 'package:weather_app/fectures/weather/data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> getWeatherInfo({required String location});
}
