import 'package:flutter/material.dart';

class TimerPager extends StatefulWidget {
  static String routeName = 'timer';

  const TimerPager({Key? key}) : super(key: key);

  @override
  State<TimerPager> createState() => _TimerPagerState();
}

class _TimerPagerState extends State<TimerPager> {

  int timer = 0;
  @override
  void initState() {
    super.initState();

    infiniteLoopAsync();
  }

  void infiniteLoopAsync() async {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        timer++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$timer',
          style: TextStyle(fontSize: 48),
        ),
      ),
    );
  }
}
