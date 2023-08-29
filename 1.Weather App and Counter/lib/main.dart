import 'package:flutter/material.dart';
import 'package:flutter_application_1/counter/counter_bloc.dart';
import 'package:flutter_application_1/counter/counter_page.dart';
import 'package:flutter_application_1/list/list_bloc.dart';
import 'package:flutter_application_1/list/list_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        // 'login': (BuildContext context) {
        //   return LoginPage();
        // },
        // 'signup': (BuildContext context) {
        //   return SignupPage();
        // },
        // 'home': (BuildContext context) {
        //   return HomePage();
        // },
        // TimerPager.routeName: (BuildContext context) {
        //   return TimerPager();
        // },
        CounterPage.routeName: (BuildContext context) {
          return BlocProvider(
            create: (context) {
              return CounterBloc();
            },
            child: CounterPage(),
          );
        },
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Weather App'),
              Tab(text: 'Counter'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (BuildContext context) {
                return ListBloc();
              },
              child: ListScreen(),
            ),
            BlocProvider(
              create: (BuildContext context) {
                return CounterBloc();
              },
              child: CounterPage(),
            ),
          ],
        ),
      ),
    );
  }
}
