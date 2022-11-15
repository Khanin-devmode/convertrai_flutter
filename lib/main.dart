import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ConverRaiApp());
}

enum ConvertingUnit { sqm, rai, ngan, wha, combined }

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
  double _sqWha = 0;
  double _fullRai = 0;
  double _fullNgan = 0;
  double _fullSqWha = 0;
  double _totalSqWha = 0;

  ConvertingUnit selectedUnit = ConvertingUnit.sqm;

  // final _sqmTextController = TextEditingController(text: '1600');
  // final _raiTextController = TextEditingController(text: '1');
  // final _nganTextController = TextEditingController(text: '0');
  // final _sqWaaTextController = TextEditingController(text: '0');
  final _inputTextController = TextEditingController(text: '1600');

  String getUnitText(ConvertingUnit unit) {
    switch (unit) {
      case ConvertingUnit.rai:
        return 'ไร่';
      case ConvertingUnit.ngan:
        return 'งาน';
      case ConvertingUnit.wha:
        return 'ตรว.';
      case ConvertingUnit.sqm:
        return 'ตรม.';
      case ConvertingUnit.combined:
        return 'ไร่/งาน/วา';
    }
  }

  void convertSqm(String txtInputSqm) {
    var n = double.tryParse(txtInputSqm);

    _sqm = (n != null) ? n : 0;
    double sqWaaRemainder;
    setState(() {
      _totalSqWha = _sqm / 4;
      _rai = (_totalSqWha / 400).floorToDouble();
      sqWaaRemainder = _totalSqWha.remainder(400);
      _ngan = (sqWaaRemainder / 100).floorToDouble();
      _sqWha = sqWaaRemainder.remainder(100);

      _fullRai = _sqm / 400;
      _fullNgan = _sqm / 100;
      _fullSqWha = _sqm / 4;

      // _raiTextController.text = _rai.toString();
      // _nganTextController.text = _ngan.toString();
      // _sqWaaTextController.text = _sqWaa.toString();
    });
  }

  void selectUnit(newUnit) {
    setState(() {
      selectedUnit = newUnit;
    });
  }

  // void updateSqmState() {
  //   setState(() {
  //     _sqm = (_rai * 1600) + (_ngan * 400) + (_sqWaa * 4);
  //     _sqmTextController.text = _sqm.toString();
  //   });
  // }

  // void convertRai(String txtRaiInput) {
  //   var n = double.tryParse(txtRaiInput);
  //   _rai = (n != null) ? n : 0;
  //   updateSqmState();
  // }

  // void convertNgan(String txtRaiInput) {
  //   var n = double.tryParse(txtRaiInput);
  //   _ngan = (n != null) ? n : 0;
  //   updateSqmState();
  // }

  // void convertSqWaa(String txtRaiInput) {
  //   var n = double.tryParse(txtRaiInput);
  //   _sqWaa = (n != null) ? n : 0;
  //   updateSqmState();
  // }

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
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextField(
                      onChanged: convertSqm,
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
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
            Row(
              children: [Text('= $_rai ไร่ $_ngan งาน $_sqWha ตรว.')],
            ),
            Row(
              children: [Text('= $_fullRai ไร่')],
            ),
            Row(
              children: [Text('= $_fullNgan งาน')],
            ),
            Row(
              children: [Text('= $_fullSqWha ตรว.')],
            ),
            // InputRow(
            //   unit: _sqm,
            //   inputLabel: 'ตรม.',
            //   unitLabel: 'ตรม.',
            //   textEditingController: _sqmTextController,
            //   onChanged: convertSqm,
            //   getUnitText: getUnitText,
            //   selectedUnit: ConvertingUnit.sqm,
            // ),
            // Text('เปลี่ยนหน่วยที่ดินไร่'),
            // InputRow(
            //     unit: _rai,
            //     inputLabel: 'ไร่',
            //     unitLabel: 'ไร่',
            //     textEditingController: _raiTextController,
            //     onChanged: convertRai),
            // InputRow(
            //     unit: _ngan,
            //     inputLabel: 'งาน',
            //     unitLabel: 'งาน',
            //     textEditingController: _nganTextController,
            //     onChanged: convertNgan),
            // InputRow(
            //     unit: _sqWaa,
            //     inputLabel: 'ตรว.',
            //     unitLabel: 'ตรว.',
            //     textEditingController: _sqWaaTextController,
            //     onChanged: convertSqWaa),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// class InputRow extends StatelessWidget {
//   InputRow({
//     Key? key,
//     required this.unit,
//     required this.inputLabel,
//     required this.unitLabel,
//     required this.onChanged,
//     required this.getUnitText,
//     required this.textEditingController,
//     required this.selectedUnit,
//   }) : super(key: key);

//   double unit;
//   final String inputLabel;
//   final String unitLabel;
//   final Function(String) onChanged;
//   final Function(ConvertingUnit) getUnitText;
//   final TextEditingController textEditingController;
//   ConvertingUnit selectedUnit;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Flexible(
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: TextField(
//               onChanged: onChanged,
//               controller: textEditingController,
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//               inputFormatters: <TextInputFormatter>[
//                 FilteringTextInputFormatter.allow(
//                   RegExp(r'[0-9]'),
//                 ),
//               ],
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(), labelText: inputLabel),
//             ),
//           ),
//         ),
//         Flexible(
//           flex: 2,
//           child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               // child: Text(unitLabel)),
//               child: DropdownButton<ConvertingUnit>(
//                 value: selectedUnit,
//                 items: ConvertingUnit.values.map((ConvertingUnit unit) {
//                   return DropdownMenuItem<ConvertingUnit>(
//                       value: unit, child: Text(getUnitText(unit)));
//                 }).toList(),
//                 onChanged: (value) {},
//               )),
//         )
//       ],
//     );
//   }
// }
