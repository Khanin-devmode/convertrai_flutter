import 'package:convertrai_flutter/constants.dart';
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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

  String getResultText(ConvertingUnit inputUnit, ConvertingUnit outputUnit) {
    String inputText;

    if (inputUnit != ConvertingUnit.combined) {
      inputText = '${_inputTextController.text} ${getUnitText(selectedUnit)}';
    } else {
      inputText =
          '${_raiTextController.text} ไร่ ${_nganTextController.text} งาน ${_sqWhaTextController.text} ตรว.';
    }

    switch (outputUnit) {
      case ConvertingUnit.rai:
        {
          return '$inputText = $_fullRai ไร่';
        }
      case ConvertingUnit.ngan:
        {
          return '$inputText = $_fullNgan งาน';
        }
      case ConvertingUnit.sqWha:
        {
          return '$inputText = $_fullSqWha ตรว.';
        }
      case ConvertingUnit.sqm:
        {
          return '$inputText = $_sqm ตรม.';
        }
      case ConvertingUnit.combined:
        {
          return '$inputText = $_rai ไร่ $_ngan งาน $_sqWha ตรว.';
        }
    }
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
        title: Text('ConvertRai'),
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
                      ? UnitInputField(
                          convertUnit: convertUnit,
                          label: 'เปลี่ยนหน่วย ${getUnitText(selectedUnit)}',
                          textEditingController: _inputTextController)
                      : Row(
                          children: [
                            Flexible(
                              child: UnitInputField(
                                  convertUnit: convertRai,
                                  label: 'ไร่',
                                  textEditingController: _raiTextController),
                            ),
                            Flexible(
                              child: UnitInputField(
                                  convertUnit: convertNgan,
                                  label: 'งาน',
                                  textEditingController: _nganTextController),
                            ),
                            Flexible(
                              child: UnitInputField(
                                  convertUnit: convertRai,
                                  label: 'ตรว.',
                                  textEditingController: _sqWhaTextController),
                            ),
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
                ? ResultRow(
                    resultText:
                        getResultText(selectedUnit, ConvertingUnit.combined))
                : Row(),
            selectedUnit != ConvertingUnit.sqm
                ? ResultRow(
                    resultText: getResultText(selectedUnit, ConvertingUnit.sqm))
                : Row(),
            selectedUnit != ConvertingUnit.rai
                ? ResultRow(
                    resultText: getResultText(selectedUnit, ConvertingUnit.rai))
                : Row(),
            selectedUnit != ConvertingUnit.ngan
                ? ResultRow(
                    resultText:
                        getResultText(selectedUnit, ConvertingUnit.ngan))
                : Row(),
            selectedUnit != ConvertingUnit.sqWha
                ? ResultRow(
                    resultText:
                        getResultText(selectedUnit, ConvertingUnit.sqWha))
                : Row(),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ResultRow extends StatelessWidget {
  const ResultRow({
    Key? key,
    required this.resultText,
  }) : super(key: key);

  final String resultText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Text(resultText),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(Icons.copy),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: resultText));
            },
          ),
        )
      ],
    );
  }
}

class UnitInputField extends StatelessWidget {
  const UnitInputField(
      {super.key,
      required this.convertUnit,
      required this.label,
      required this.textEditingController});

  final Function(String) convertUnit;
  final TextEditingController textEditingController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextField(
        onChanged: convertUnit,
        controller: textEditingController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: kNumberInputFormatter,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text(label),
        ),
      ),
    );
  }
}
