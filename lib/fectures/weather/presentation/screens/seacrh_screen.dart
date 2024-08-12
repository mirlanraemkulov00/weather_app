import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:weather_app/fectures/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/fectures/weather/domain/use_cases/weather_use_case.dart';
import 'package:weather_app/fectures/weather/presentation/logic/bloc/weather_bloc.dart';
import 'package:weather_app/fectures/weather/presentation/screens/weather_info_screen.dart';

class SeacrhScreen extends StatelessWidget {
  const SeacrhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    final WeatherBloc bloc = WeatherBloc(
      weatherUseCase: WeatherUseCase(
        weatherRepository: WeatherRepositoryImpl(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Weather My App'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'enter location',
                    suffix: Icon(Icons.search),
                  ),
                  controller: controller,
                ),
              ),
              BlocListener<WeatherBloc, WeatherState>(
                bloc: bloc,
                listener: (context, state) {
                  showLoader(state is WeatherLoadingState);

                  if (state is WeatherLoadedState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherInfoScreen(
                          weatherModel: state.model,
                        ),
                      ),
                    );
                  }

                  if (state is WeatherErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.error.message.toString(),
                        ),
                      ),
                    );
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    bloc.add(
                      GetWeatherEvent(location: controller.text),
                    );
                  },
                  child: Text('Поиск'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showLoader(bool showLoader) {
  if (showLoader) {
    EasyLoading.show();
  } else {
    EasyLoading.dismiss();
  }
}
