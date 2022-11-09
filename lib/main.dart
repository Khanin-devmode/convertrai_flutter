import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ConverRaiApp());
}

class ConverRaiApp extends StatelessWidget {
  const ConverRaiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ConvertRai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text('เปลี่ยนหน่วยที่ดินตามรางเมตร'),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ที่ดินตารางเมตร'),
                  ),
                ),
                Text('ตารางเมตร')
              ],
            ),
            Text('เปลี่ยนหน่วยที่ดินไร่'),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'ไร่'),
                  ),
                ),
                Text('ไร่')
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'งาน'),
                  ),
                ),
                Text('งาน')
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'วา'),
                  ),
                ),
                Text('วา')
              ],
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
