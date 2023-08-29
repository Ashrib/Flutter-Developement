import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBloc extends Bloc<BaseListEvent, ListState> {
  ListBloc() : super(ListState()) {
    on<LoadListEvent>((event, emit) async {
      Dio dio = Dio();
      String cityName = event.cityName;

      emit(state.copyWith(isLoading: true)); // Update loading status

      try {
        final response = await dio.get(
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=e0f99c494c2ce394a18cc2fd3f100543');

        final data = response.data as Map<String, dynamic>;
        print(data);

        ListState newState =
            ListState(weatherData: data, isLoading: false, searchSuccess: true);
        emit(newState);
      } catch (e) {
        ListState newState = ListState(isLoading: false, searchSuccess: false);
        emit(newState);
      }
    });
  }
}

abstract class BaseListEvent {}

class LoadListEvent extends BaseListEvent {
  final String cityName;

  LoadListEvent(this.cityName);
}

class ListState {
  final Map<String, dynamic>? weatherData;
  final bool isLoading;
  final bool searchSuccess; // Add this flag

  ListState({
    this.weatherData,
    this.isLoading = false,
    this.searchSuccess = true, // Initialize the flag as true
  });

  ListState copyWith({
    Map<String, dynamic>? weatherData,
    bool? isLoading,
  }) {
    return ListState(
      weatherData: weatherData ?? this.weatherData,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
