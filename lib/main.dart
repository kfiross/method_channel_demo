import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_method_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _output = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Method Channel Demo app"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Get Platform Version"),
            onPressed: _getPlatform,
          ),
          RaisedButton(
            child: Text("Perform Calculation"),
            onPressed: _performCalc,
          ),
          SizedBox(height: 10),
          Text("$_output")
        ],
      ),
    );
  }

  /// get the version of the running device
  void _getPlatform() async {
    try {
      var version = await MyMethodChannel.getPlatformVersion();
      setState(() {
        _output = version;
      });
    } on PlatformException catch (e) {
      debugPrint("${e.message}");
    }
  }

  /// performs a mocked calculation on the native side
  void _performCalc() async {
    try {
      var sum = await MyMethodChannel.getCalculation(3, 5);
      setState(() {
        _output = "$sum";
      });
    } on PlatformException catch (e) {
      debugPrint("${e.message}");
    }
  }
}
