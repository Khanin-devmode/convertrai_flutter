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

  void convertSqm(String txtInputSqm) {
    var n = double.tryParse(txtInputSqm);

    _sqm = (n != null) ? n : 0;
    double sqWaaRemainder;
    setState(() {
      _totalSqWaa = _sqm / 4;
      _rai = (_totalSqWaa / 400).floorToDouble();
      sqWaaRemainder = _totalSqWaa.remainder(400);
      _ngan = (sqWaaRemainder / 100).floorToDouble();
      _sqWaa = sqWaaRemainder.remainder(100);

      _raiTextController.text = _rai.toString();
      _nganTextController.text = _ngan.toString();
      _sqWaaTextController.text = _sqWaa.toString();
    });
  }

  void updateSqmState() {
    setState(() {
      _sqm = (_rai * 1600) + (_ngan * 400) + (_sqWaa * 4);
      _sqmTextController.text = _sqm.toString();
    });
  }

  void convertRai(String txtRaiInput) {
    var n = double.tryParse(txtRaiInput);
    _rai = (n != null) ? n : 0;
    updateSqmState();
  }

  void convertNgan(String txtRaiInput) {
    var n = double.tryParse(txtRaiInput);
    _ngan = (n != null) ? n : 0;
    updateSqmState();
  }

  void convertSqWaa(String txtRaiInput) {
    var n = double.tryParse(txtRaiInput);
    _sqWaa = (n != null) ? n : 0;
    updateSqmState();
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
              onChanged: convertSqm,
            ),
            Text('เปลี่ยนหน่วยที่ดินไร่'),
            InputRow(
                unit: _rai,
                inputLabel: 'ไร่',
                unitLabel: 'ไร่',
                textEditingController: _raiTextController,
                onChanged: convertRai),
            InputRow(
                unit: _ngan,
                inputLabel: 'งาน',
                unitLabel: 'งาน',
                textEditingController: _nganTextController,
                onChanged: convertNgan),
            InputRow(
                unit: _sqWaa,
                inputLabel: 'ตรว.',
                unitLabel: 'ตรว.',
                textEditingController: _sqWaaTextController,
                onChanged: convertSqWaa),
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
      required this.onChanged,
      required this.textEditingController})
      : super(key: key);

  double unit;
  final String inputLabel;
  final String unitLabel;
  final Function(String) onChanged;
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
              onChanged: onChanged,
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
