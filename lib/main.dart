import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ConverRaiApp());
}

enum ConvertingUnit { sqm, rai, ngan, sqWha, combined }

class ConverRaiApp extends StatelessWidget {
  const ConverRaiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convert Rai',
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
  double _sqm = 0;
  double _rai = 0;
  double _ngan = 0;
  double _sqWha = 0;
  double _fullRai = 0;
  double _fullNgan = 0;
  double _fullSqWha = 0;
  double _totalSqWha = 0;

  ConvertingUnit selectedUnit = ConvertingUnit.sqm;

  final _inputTextController = TextEditingController();
  final _raiTextController = TextEditingController();
  final _nganTextController = TextEditingController();
  final _sqWhaTextController = TextEditingController();

  void selectUnit(newUnit) {
    setState(() {
      selectedUnit = newUnit;
    });

    convertUnit(_inputTextController.text);
  }

  String getUnitText(ConvertingUnit unit) {
    switch (unit) {
      case ConvertingUnit.rai:
        return 'ไร่';
      case ConvertingUnit.ngan:
        return 'งาน';
      case ConvertingUnit.sqWha:
        return 'ตรว.';
      case ConvertingUnit.sqm:
        return 'ตรม.';
      case ConvertingUnit.combined:
        return 'ไร่/งาน/วา';
    }
  }

  void convertUnit(String txtInputUnit) {
    var n = double.tryParse(txtInputUnit);

    switch (selectedUnit) {
      case ConvertingUnit.rai:
        {
          _sqm = (n != null) ? n * 1600 : 0;
        }
        break;
      case ConvertingUnit.ngan:
        {
          _sqm = (n != null) ? n * 400 : 0;
        }
        break;
      case ConvertingUnit.sqWha:
        {
          _sqm = (n != null) ? n * 4 : 0;
        }
        break;
      case ConvertingUnit.sqm:
        {
          _sqm = (n != null) ? n : 0;
        }
        break;
      case ConvertingUnit.combined:
        {}
        break;
    }

    double sqWaaRemainder;
    setState(() {
      _totalSqWha = _sqm / 4;
      _rai = (_totalSqWha / 400).floorToDouble();
      sqWaaRemainder = _totalSqWha.remainder(400);
      _ngan = (sqWaaRemainder / 100).floorToDouble();
      _sqWha = sqWaaRemainder.remainder(100);

      _fullRai = _sqm / 1600;
      _fullNgan = _sqm / 400;
      _fullSqWha = _sqm / 4;

      _raiTextController.text = _rai.toString();
      _nganTextController.text = _ngan.toString();
      _sqWhaTextController.text = _sqWha.toString();
    });
  }

  void convertRai(String raiTextInput) {
    var n = double.tryParse(raiTextInput);

    _rai = (n != null) ? n : 0;

    setState(() {
      _sqm = (_rai * 1600) + (_ngan * 400) + (_sqWha) * 4;
      _fullRai = _sqm / 1600;
      _fullNgan = _sqm / 400;
      _fullSqWha = _sqm / 4;
    });
  }

  void convertNgan(String raiTextInput) {
    var n = double.tryParse(raiTextInput);

    _ngan = (n != null) ? n : 0;

    setState(() {
      _sqm = (_rai * 1600) + (_ngan * 400) + (_sqWha) * 4;
      _fullRai = _sqm / 1600;
      _fullNgan = _sqm / 400;
      _fullSqWha = _sqm / 4;
    });
  }

  void convertSqWha(String raiTextInput) {
    var n = double.tryParse(raiTextInput);

    _sqWha = (n != null) ? n : 0;

    setState(() {
      _sqm = (_rai * 1600) + (_ngan * 400) + (_sqWha) * 4;
      _fullRai = _sqm / 1600;
      _fullNgan = _sqm / 400;
      _fullSqWha = _sqm / 4;
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
            Text('เปลี่ยนหน่วยที่ดิน'),
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: selectedUnit != ConvertingUnit.combined
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: TextField(
                            onChanged: convertUnit,
                            controller: _inputTextController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(
                                'ขนาดพื้นที่ ' + getUnitText(selectedUnit),
                              ),
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            Flexible(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _raiTextController,
                                onChanged: convertRai,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text(
                                    'ไร่ ',
                                  ),
                                ),
                              ),
                            )),
                            Flexible(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _nganTextController,
                                onChanged: convertNgan,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text(
                                    'งาน',
                                  ),
                                ),
                              ),
                            )),
                            Flexible(
                                child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _sqWhaTextController,
                                onChanged: convertSqWha,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text(
                                    'ตรว.',
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      // child: Text(unitLabel)),
                      child: DropdownButton<ConvertingUnit>(
                        value: selectedUnit,
                        items: ConvertingUnit.values.map((ConvertingUnit unit) {
                          return DropdownMenuItem<ConvertingUnit>(
                              value: unit, child: Text(getUnitText(unit)));
                        }).toList(),
                        onChanged: selectUnit,
                      )),
                )
              ],
            ),
            selectedUnit != ConvertingUnit.combined
                ? Row(
                    children: [Text('= $_rai ไร่ $_ngan งาน $_sqWha ตรว.')],
                  )
                : Row(),
            selectedUnit != ConvertingUnit.sqm
                ? Row(
                    children: [Text('= $_sqm ตรม.')],
                  )
                : Row(),
            selectedUnit != ConvertingUnit.rai
                ? Row(
                    children: [Text('= $_fullRai ไร่')],
                  )
                : Row(),
            selectedUnit != ConvertingUnit.ngan
                ? Row(
                    children: [Text('= $_fullNgan งาน')],
                  )
                : Row(),
            selectedUnit != ConvertingUnit.sqWha
                ? Row(
                    children: [Text('= $_fullSqWha ตรว.')],
                  )
                : Row(),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
