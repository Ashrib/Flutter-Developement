import 'package:flutter/material.dart';
import 'package:flutter_application_1/list/list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListScreen extends StatefulWidget {
  static String routeName = 'list';

  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late TextEditingController _cityController;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  void _searchButtonClicked() {
    String cityName = _cityController.text;
    if (cityName.isEmpty) {
      setState(() {
        _errorMessage = 'City name cannot be empty';
      });
    } else if (RegExp(r'[0-9]').hasMatch(cityName)) {
      setState(() {
        _errorMessage = 'City name cannot contain numbers';
      });
    } else {
      // Clear previous error message
      setState(() {
        _errorMessage = '';
      });

      // Send event to the Bloc
      final bloc = context.read<ListBloc>();
      bloc.add(LoadListEvent(cityName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Weather App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter city name',
                      errorText:
                          _errorMessage.isNotEmpty ? _errorMessage : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _searchButtonClicked,
                    child: Text('Search'),
                  ),
                  if (state.weatherData != null)
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Weather in ${state.weatherData!['name']}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Description: ${state.weatherData!['weather'][0]['description']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Temperature: ${state.weatherData!['main']['temp']}°C',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Humidity: ${state.weatherData!['main']['humidity']}%',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Wind Speed: ${state.weatherData!['wind']['speed']} m/s',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (!state.searchSuccess && !state.isLoading)
                    Text(
                      'No result found',
                      style: TextStyle(fontSize: 16),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
