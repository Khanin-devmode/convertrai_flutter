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
  double waa = 0;

  void convertSqm() {}

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
            InputRow(unit: sqm, inputLabel: 'ตรม.', unitLabel: 'ตรม.'),
            Text('เปลี่ยนหน่วยที่ดินไร่'),
            InputRow(unit: rai, inputLabel: 'ไร่', unitLabel: 'ไร่'),
            InputRow(unit: ngan, inputLabel: 'งาน', unitLabel: 'งาน'),
            InputRow(unit: waa, inputLabel: 'วา', unitLabel: 'วา'),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class InputRow extends StatelessWidget {
  const InputRow({
    Key? key,
    required this.unit,
    required this.inputLabel,
    required this.unitLabel,
  }) : super(key: key);

  final double unit;
  final String inputLabel;
  final String unitLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 5,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
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
