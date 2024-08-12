part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitialState extends WeatherState {}

final class WeatherLoadingState extends WeatherState {}

final class WeatherLoadedState extends WeatherState {
  final WeatherModel model;

  WeatherLoadedState({required this.model});
}

final class WeatherErrorState extends WeatherState {
  final CatchException error;

  WeatherErrorState({required this.error});
}
