import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomepageArgument? getArgument =
        ModalRoute.of(context)!.settings.arguments as HomepageArgument?;

    if (getArgument != null) {
      print(getArgument.id);
      print(getArgument.name);
    }

    Navigator.of(context).pop('ashdkfajs');

    // String argumentValue = ModalRoute.of(context)!.settings.arguments as String;

    // userNameController.text = argumentValue;
    print('Build Method called');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Application'),
      ),
      body: Column(
        children: [
          TextField(
            controller: userNameController,
            onChanged: (text) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: 'User Name',
              labelText: 'User Name',
              errorText: null,
              counterText: 'User Name Counter',
            ),
          ),
          Text(userNameController.text),
        ],
      ),
    );
  }
}

class HomepageArgument {
  String id;
  String name;

  HomepageArgument(this.id, this.name);
}
