import 'package:convert_rai/calculate_logic.dart';
import 'package:convert_rai/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import '../ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConverterPage extends ConsumerStatefulWidget {
  const ConverterPage({super.key});

  @override
  ConverterPageState createState() => ConverterPageState();
}

class ConverterPageState extends ConsumerState<ConverterPage> {
  final _inputTextController = TextEditingController(text: '1600');
  final _raiTextController = TextEditingController();
  final _nganTextController = TextEditingController();
  final _sqWhaTextController = TextEditingController();

  List<String> saveResults = [];

  BannerAd? _bannerAd;

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
    final calState = ref.watch(calNotifierProvider);
    final calNotifier = ref.watch(calNotifierProvider.notifier);

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
              children: [
                Flexible(
                    flex: 4,
                    child: calState.selectedUnit != ConvertingUnit.raiNganSqWha
                        ? UnitInputField(
                            convertUnit: (calNotifier.convertUnit),
                            label:
                                'เปลี่ยนหน่วย ${getUnitText(calState.selectedUnit)}',
                            textEditingController: _inputTextController)
                        // : Row(
                        //     children: [
                        //       Flexible(
                        //         child: UnitInputField(
                        //             convertUnit: convertRai,
                        //             label: 'ไร่',
                        //             textEditingController: _raiTextController),
                        //       ),
                        //       Flexible(
                        //         child: UnitInputField(
                        //             convertUnit: convertNgan,
                        //             label: 'งาน',
                        //             textEditingController: _nganTextController),
                        //       ),
                        //       Flexible(
                        //         child: UnitInputField(
                        //             convertUnit: convertSqWha,
                        //             label: 'ตรว.',
                        //             textEditingController: _sqWhaTextController),
                        //       ),
                        //     ],
                        //   ),
                        : SizedBox()),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    margin: const EdgeInsets.only(right: 9),
                    // child: Text(unitLabel)),
                    child: DropdownButton<ConvertingUnit>(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      alignment: Alignment.center,
                      value: calState.selectedUnit,
                      items: ConvertingUnit.values.map((ConvertingUnit unit) {
                        return DropdownMenuItem<ConvertingUnit>(
                            value: unit, child: Text(getUnitText(unit)));
                      }).toList(),
                      onChanged: null,
                    ),
                  ),
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
                  // calState.selectedUnit != ConvertingUnit.combined
                  //     ? ResultRow(
                  //         resultText: getResultText(
                  //           selectedUnit,
                  //           ConvertingUnit.combined,
                  //         ),
                  //         saveFunction: saveResult,
                  //       )
                  //     : Row(),
                  calState.selectedUnit != ConvertingUnit.sqm
                      ? ResultRow(
                          resultText: getResultText(0, calState.selectedUnit,
                              calState.sqm, ConvertingUnit.sqm),
                          saveFunction: saveResult,
                        )
                      : Row(),
                  calState.selectedUnit != ConvertingUnit.rai
                      ? ResultRow(
                          resultText: getResultText(0, calState.selectedUnit,
                              calState.fullRai, ConvertingUnit.rai),
                          saveFunction: saveResult,
                        )
                      : Row(),
                  calState.selectedUnit != ConvertingUnit.ngan
                      ? ResultRow(
                          resultText: getResultText(0, calState.selectedUnit,
                              calState.fullNgan, ConvertingUnit.ngan),
                          saveFunction: saveResult,
                        )
                      : Row(),
                  calState.selectedUnit != ConvertingUnit.sqWha
                      ? ResultRow(
                          resultText: getResultText(0, calState.selectedUnit,
                              calState.fullSqWha, ConvertingUnit.sqWha),
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
                ? SafeArea(
                    bottom: true,
                    child: Container(
                      color: Colors.blue,
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      alignment: Alignment.center,
                      // child: Text('Ad Banner'),
                      child: AdWidget(ad: _bannerAd!),
                    ),
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
    case ConvertingUnit.raiNganSqWha:
      return 'ไร่/งาน/ตรว.';
  }
}

String getResultText(double input, ConvertingUnit inputUnit, double output,
    ConvertingUnit outputUnit) {
  return '$input ${getUnitText(inputUnit)} = $output ${getUnitText(outputUnit)}';
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

class UnitInputField extends StatelessWidget {
  const UnitInputField(
      {super.key,
      required this.convertUnit,
      required this.label,
      required this.textEditingController});

  final Function(double) convertUnit;
  final TextEditingController textEditingController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: TextField(
        onChanged: (newValue) {
          String pureNum = newValue.replaceAll(RegExp('[^A-Za-z0-9]'), '');
          double n;
          if (pureNum.isNotEmpty) {
            n = double.parse(pureNum);
          } else {
            n = 0;
          }

          convertUnit(n);
        },
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
