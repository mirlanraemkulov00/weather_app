import 'package:dio/dio.dart';
import 'package:weather_app/fectures/weather/data/models/weather_model.dart';
import 'package:weather_app/fectures/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/internals/helpers/api_requester.dart';
import 'package:weather_app/internals/helpers/catch_exception.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final ApiRequester apiRequester = ApiRequester();

  @override
  Future<WeatherModel> getWeatherInfo({required String location}) async {
    try {
      Response response = await apiRequester.toGet(
        'data/2.5/weather',
        params: {
          'q': location,
          'appid': 'd0617a5c2dca461ecff826af2453a679',
          'lang': 'ru',
        },
      );

      print(response.data);

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      print('getWeatherinfo = $e');
      throw CatchException.convertException(e);
    }
  }
}
