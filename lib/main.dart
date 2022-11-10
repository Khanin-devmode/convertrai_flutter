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
  double sqm = 4000;
  double rai = 1;
  double ngan = 0;
  double sqWaa = 0;
  double totalSqWaa = 0;

  void convertSqm(double inputSqm) {
    double sqWaaRemainder;

    setState(() {
      totalSqWaa = inputSqm / 4;
      rai = (totalSqWaa / 400).floorToDouble();
      sqWaaRemainder = totalSqWaa.remainder(400);
      ngan = (sqWaaRemainder / 100).floorToDouble();
      sqWaa = sqWaaRemainder.remainder(100);
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
            InputRow(
                key: Key('1'),
                unit: sqm,
                inputLabel: 'ตรม.',
                unitLabel: 'ตรม.',
                onChange: convertSqm),
            Text('เปลี่ยนหน่วยที่ดินไร่'),
            InputRow(
                key: Key('2'),
                unit: rai,
                inputLabel: 'ไร่',
                unitLabel: 'ไร่',
                onChange: () {}),
            InputRow(
                key: Key('3'),
                unit: ngan,
                inputLabel: 'งาน',
                unitLabel: 'งาน',
                onChange: () {}),
            InputRow(
                key: Key('4'),
                unit: sqWaa,
                inputLabel: 'วา',
                unitLabel: 'วา',
                onChange: () {}),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class InputRow extends StatelessWidget {
  const InputRow(
      {Key? key,
      required this.unit,
      required this.inputLabel,
      required this.unitLabel,
      required this.onChange})
      : super(key: key);

  final double unit;
  final String inputLabel;
  final String unitLabel;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              onChanged: (value) {
                onChange();
              },
              controller: TextEditingController(text: unit.toStringAsFixed(2)),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]'),
                ),
              ],
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: inputLabel),
            ),
          ),
        ),
        Flexible(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(unitLabel)),
        )
      ],
    );
  }
}
