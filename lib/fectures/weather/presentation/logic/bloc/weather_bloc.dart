import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/fectures/weather/domain/use_cases/weather_use_case.dart';
import 'package:weather_app/internals/helpers/catch_exception.dart';

import '../../../data/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherUseCase weatherUseCase;

  WeatherBloc({required this.weatherUseCase}) : super(WeatherInitialState()) {
    on<GetWeatherEvent>(
      (event, emit) async {
        emit(WeatherLoadingState());

        try {
          final WeatherModel result =
              await weatherUseCase.getWeatherInfo(location: event.location);

          emit(WeatherLoadedState(model: result));
        } catch (e) {
          emit(
            WeatherErrorState(
              error: CatchException.convertException(e),
            ),
          );
        }
      },
    );
  }
}
