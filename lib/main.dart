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
  double _sqm = 1600;
  double _rai = 1;
  double _ngan = 0;
  double _sqWaa = 0;
  double _totalSqWaa = 0;

  final _sqmTextController = TextEditingController(text: '1600');
  final _raiTextController = TextEditingController(text: '1');
  final _nganTextController = TextEditingController(text: '0');
  final _sqWaaTextController = TextEditingController(text: '0');

  void convertSqm(double inputSqm) {
    double sqWaaRemainder;

    setState(() {
      _totalSqWaa = inputSqm / 4;
      _rai = (_totalSqWaa / 400).floorToDouble();
      sqWaaRemainder = _totalSqWaa.remainder(400);
      _ngan = (sqWaaRemainder / 100).floorToDouble();
      _sqWaa = sqWaaRemainder.remainder(100);

      _raiTextController.text = _rai.toStringAsFixed(0);
      _nganTextController.text = _ngan.toStringAsFixed(0);
      _sqWaaTextController.text = _sqWaa.toStringAsFixed(0);
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
              unit: _sqm,
              inputLabel: 'ตรม.',
              unitLabel: 'ตรม.',
              textEditingController: _sqmTextController,
              onChange: convertSqm,
            ),
            Text('เปลี่ยนหน่วยที่ดินไร่'),
            InputRow(
                unit: _rai,
                inputLabel: 'ไร่',
                unitLabel: 'ไร่',
                textEditingController: _raiTextController,
                onChange: () {}),
            InputRow(
                unit: _ngan,
                inputLabel: 'งาน',
                unitLabel: 'งาน',
                textEditingController: _nganTextController,
                onChange: () {}),
            InputRow(
                unit: _sqWaa,
                inputLabel: 'ตรว.',
                unitLabel: 'ตรว.',
                textEditingController: _sqWaaTextController,
                onChange: () {}),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class InputRow extends StatelessWidget {
  InputRow(
      {Key? key,
      required this.unit,
      required this.inputLabel,
      required this.unitLabel,
      required this.onChange,
      required this.textEditingController})
      : super(key: key);

  double unit;
  final String inputLabel;
  final String unitLabel;
  final Function onChange;
  final TextEditingController textEditingController;

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
                print('value: ' + value);
                var n = double.tryParse(value);
                n != null ? onChange(n) : print('value is null');
              },
              controller: textEditingController,
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
