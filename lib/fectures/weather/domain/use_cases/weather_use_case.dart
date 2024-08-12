import 'package:weather_app/fectures/weather/data/models/weather_model.dart';
import 'package:weather_app/fectures/weather/domain/repositories/weather_repository.dart';

class WeatherUseCase {
  final WeatherRepository weatherRepository;

  WeatherUseCase({required this.weatherRepository});

  Future<WeatherModel> getWeatherInfo({required String location}) async {
    return await weatherRepository.getWeatherInfo(location: location);
  }
}
