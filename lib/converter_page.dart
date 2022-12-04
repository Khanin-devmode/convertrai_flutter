import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum ConvertingUnit { sqm, rai, ngan, sqWha, combined }

class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  double _sqm = 1600;
  double _rai = 1;
  double _ngan = 0;
  double _sqWha = 0;
  double _fullRai = 1;
  double _fullNgan = 4;
  double _fullSqWha = 400;
  double _totalSqWha = 0;

  ConvertingUnit selectedUnit = ConvertingUnit.sqm;

  final _inputTextController = TextEditingController(text: '1600');
  final _raiTextController = TextEditingController();
  final _nganTextController = TextEditingController();
  final _sqWhaTextController = TextEditingController();

  List<String> saveResults = [];

  BannerAd? _bannerAd;

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
        return 'ไร่/งาน/ตรว.';
    }
  }

  void convertUnit(String txtInputUnit) {
    var pureNum = txtInputUnit.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    var n = double.tryParse(pureNum);

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
        {
          _sqm = 0;
          _raiTextController.text = "";
          _nganTextController.text = "";
          _sqWhaTextController.text = "";
        }
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

      // _raiTextController.text = _rai.toString();
      // _nganTextController.text = _ngan.toString();
      // _sqWhaTextController.text = _sqWha.toString();
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
          return '$inputText = ${kNumFormat.format(_fullRai)} ไร่';
        }
      case ConvertingUnit.ngan:
        {
          return '$inputText = ${kNumFormat.format(_fullNgan)} งาน';
        }
      case ConvertingUnit.sqWha:
        {
          return '$inputText = ${kNumFormat.format(_fullSqWha)} ตรว.';
        }
      case ConvertingUnit.sqm:
        {
          return '$inputText = ${kNumFormat.format(_sqm)} ตรม.';
        }
      case ConvertingUnit.combined:
        {
          return '$inputText = ${kNumFormat.format(_rai)} ไร่ ${kNumFormat.format(_ngan)} งาน ${kNumFormat.format(_sqWha)} ตรว.';
        }
    }
  }

  void convertRai(String raiTextInput) {
    var pureNum = raiTextInput.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    var n = double.tryParse(pureNum);

    _rai = (n != null) ? n : 0;

    setState(() {
      _sqm = (_rai * 1600) + (_ngan * 400) + (_sqWha) * 4;
      _fullRai = _sqm / 1600;
      _fullNgan = _sqm / 400;
      _fullSqWha = _sqm / 4;
    });
  }

  void convertNgan(String nganTextInput) {
    var pureNum = nganTextInput.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    var n = double.tryParse(pureNum);

    _ngan = (n != null) ? n : 0;

    setState(() {
      _sqm = (_rai * 1600) + (_ngan * 400) + (_sqWha) * 4;
      _fullRai = _sqm / 1600;
      _fullNgan = _sqm / 400;
      _fullSqWha = _sqm / 4;
    });
  }

  void convertSqWha(String sqWhaTextInput) {
    var pureNum = sqWhaTextInput.replaceAll(RegExp('[^A-Za-z0-9]'), '');
    var n = double.tryParse(pureNum);

    _sqWha = (n != null) ? n : 0;

    setState(() {
      _sqm = (_rai * 1600) + (_ngan * 400) + (_sqWha) * 4;
      _fullRai = _sqm / 1600;
      _fullNgan = _sqm / 400;
      _fullSqWha = _sqm / 4;
    });
  }

  void saveResult(String result) {
    setState(() {
      saveResults.add(result);
    });
  }

  void deleteResult(int index) {
    setState(() {
      saveResults.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBgColor,
        elevation: 0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Flexible(
              flex: 6,
              child: Text(
                'Convert Rai',
                style: kTitleTextStyle,
              ),
            ),
            Flexible(
              flex: 6,
              child: Container(
                height: 8,
                decoration: const BoxDecoration(
                  color: kTitleColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: kBgColor,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  convertUnit: convertSqWha,
                                  label: 'ตรว.',
                                  textEditingController: _sqWhaTextController),
                            ),
                          ],
                        ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      margin: const EdgeInsets.only(right: 12),
                      // child: Text(unitLabel)),
                      child: DropdownButton<ConvertingUnit>(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        alignment: Alignment.center,
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
            Container(
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                children: [
                  selectedUnit != ConvertingUnit.combined
                      ? ResultRow(
                          resultText: getResultText(
                            selectedUnit,
                            ConvertingUnit.combined,
                          ),
                          saveFunction: saveResult,
                        )
                      : Row(),
                  selectedUnit != ConvertingUnit.sqm
                      ? ResultRow(
                          resultText:
                              getResultText(selectedUnit, ConvertingUnit.sqm),
                          saveFunction: saveResult,
                        )
                      : Row(),
                  selectedUnit != ConvertingUnit.rai
                      ? ResultRow(
                          resultText:
                              getResultText(selectedUnit, ConvertingUnit.rai),
                          saveFunction: saveResult,
                        )
                      : Row(),
                  selectedUnit != ConvertingUnit.ngan
                      ? ResultRow(
                          resultText:
                              getResultText(selectedUnit, ConvertingUnit.ngan),
                          saveFunction: saveResult,
                        )
                      : Row(),
                  selectedUnit != ConvertingUnit.sqWha
                      ? ResultRow(
                          resultText:
                              getResultText(selectedUnit, ConvertingUnit.sqWha),
                          saveFunction: saveResult,
                        )
                      : Row(),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Column(children: [
                Container(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'บันทึกผล',
                      style: kSecondTitleTextStyle,
                    )),
              ]),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: saveResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: saveResults.length,
                        itemBuilder: (context, index) {
                          final result = saveResults[index];
                          return SavedRow(
                            resultText: result,
                            deleteFunction: deleteResult,
                            index: index,
                          );
                        })
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("กด"),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(
                                Icons.save_outlined,
                                color: kIconColor,
                              ),
                            ),
                            Text("เพื่อบันทึกผลแปลงหน่วยที่นี่")
                          ],
                        ),
                      ),
              ),
            ),
            _bannerAd != null
                ? Container(
                    color: Colors.blue,
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    alignment: Alignment.center,
                    // child: Text('Ad Banner'),
                    child: AdWidget(ad: _bannerAd!),
                  )
                : Row(),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ResultRow extends StatelessWidget {
  const ResultRow(
      {Key? key, required this.resultText, required this.saveFunction})
      : super(key: key);

  final String resultText;
  final Function(String) saveFunction;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            // kNumFormat.format(resultText),
            resultText,
            style: kBodyText,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.save_outlined,
                color: kIconColor,
              ),
              onPressed: () async {
                saveFunction(resultText);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.copy,
                color: kIconColor,
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: resultText));
                showSnackBar(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SavedRow extends StatelessWidget {
  const SavedRow(
      {Key? key,
      required this.resultText,
      required this.deleteFunction,
      required this.index})
      : super(key: key);

  final String resultText;
  final Function(int) deleteFunction;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            resultText,
            style: kBodyText,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.delete_outlined,
                  color: kIconColor,
                ),
                onPressed: () async {
                  deleteFunction(index);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.copy,
                  color: kIconColor,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: resultText));
                  showSnackBar(context);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

void showSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1000),
      content: Container(
        height: 20,
        alignment: Alignment.center,
        child: const Text(
          'Text Copied.',
        ),
      ),
      width: 280.0, // Width of the SnackBar.
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: kSnackBarBg,
    ),
  );
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextField(
        onChanged: convertUnit,
        controller: textEditingController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [ThousandsFormatter()],
        decoration: InputDecoration(
          // label: Text(label),
          hintText: label,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
