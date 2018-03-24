import 'package:flutter/material.dart';
import 'package:transport_for_london/pages/home.dart';
import 'package:transport_for_london/pages/line.dart';
import 'package:transport_for_london/pages/lines.dart';
import 'package:transport_for_london/pages/stop_point.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new HomePage(),
      routes: <String, WidgetBuilder>{
        '/line': (BuildContext context) => new LinePage(),
        '/lines': (BuildContext context) => new LinesPage(),
        '/stop_point': (BuildContext context) => new StopPointPage(),
      },
      theme: new ThemeData.dark(),
      title: 'Transport for London',
    );
  }
}
