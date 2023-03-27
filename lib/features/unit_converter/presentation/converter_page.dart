import 'package:convert_rai/ad_helper.dart';
import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:convert_rai/features/unit_converter/domain/saving_logic.dart';
import 'package:convert_rai/features/unit_converter/presentation/widgets/custom_input.dart';
import 'package:convert_rai/features/unit_converter/presentation/widgets/result_row.dart';
import 'package:convert_rai/features/unit_converter/presentation/widgets/saved_result_row.dart';
import 'package:convert_rai/features/unit_converter/presentation/widgets/unit_select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConverterPage extends ConsumerStatefulWidget {
  const ConverterPage({super.key});

  @override
  ConverterPageState createState() => ConverterPageState();
}

class ConverterPageState extends ConsumerState<ConverterPage> {
  final singleInputCtrl = TextEditingController(text: '1');
  final raiInputCtrl = TextEditingController(text: '1');
  final nganInputCtrl = TextEditingController();
  final sqWhaInputCtrl = TextEditingController();

  BannerAd? _bannerAd;

  @override
  void initState() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          // print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();

    super.initState();
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
    final List<String> saveState = ref.watch(saveNotifierProvider);
    final saveNotifier = ref.watch(saveNotifierProvider.notifier);

    return SafeArea(
      child: Scaffold(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: calState.selectedUnit !=
                              ConvertingUnit.raiNganSqWha
                          ? CustomInputField(
                              label: getUnitText(calState.selectedUnit),
                              inputTextController: singleInputCtrl,
                              calNotifier: calNotifier,
                              onChanged: (newValue) {
                                double n = stringToDouble(newValue);
                                calNotifier.convertUnit(n);
                              },
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    label: 'ไร่',
                                    inputTextController: raiInputCtrl,
                                    calNotifier: calNotifier,
                                    onChanged: (newValue) {
                                      double rai = stringToDouble(newValue);
                                      double ngan =
                                          stringToDouble(nganInputCtrl.text);
                                      double sqWha =
                                          stringToDouble(sqWhaInputCtrl.text);
                                      calNotifier.convertCombinedUnit(
                                          rai, ngan, sqWha);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: CustomInputField(
                                    label: 'งาน',
                                    inputTextController: nganInputCtrl,
                                    calNotifier: calNotifier,
                                    onChanged: (newValue) {
                                      double rai =
                                          stringToDouble(raiInputCtrl.text);
                                      double ngan = stringToDouble(newValue);
                                      double sqWha =
                                          stringToDouble(sqWhaInputCtrl.text);
                                      calNotifier.convertCombinedUnit(
                                          rai, ngan, sqWha);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: CustomInputField(
                                    label: 'ตรว.',
                                    inputTextController: sqWhaInputCtrl,
                                    calNotifier: calNotifier,
                                    onChanged: (newValue) {
                                      double rai =
                                          stringToDouble(raiInputCtrl.text);
                                      double ngan =
                                          stringToDouble(nganInputCtrl.text);
                                      double sqWha = stringToDouble(newValue);
                                      calNotifier.convertCombinedUnit(
                                          rai, ngan, sqWha);
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 2,
                      child: UnitSelectDropdown(
                        calState: calState,
                        calNotifier: calNotifier,
                        singleInputCtrl: singleInputCtrl,
                        raiInputCtrl: raiInputCtrl,
                        nganInputCtrl: nganInputCtrl,
                        sqWhaInputCtrl: sqWhaInputCtrl,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    calState.selectedUnit != ConvertingUnit.raiNganSqWha
                        ? ResultRow(
                            resultText:
                                '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.rai)} ไร่ ${kNumFormat.format(calState.ngan)} งาน ${kNumFormat.format(calState.sqWha)} ตรว.',
                          )
                        : const SizedBox(),
                    calState.selectedUnit != ConvertingUnit.sqm
                        ? ResultRow(
                            resultText:
                                '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.sqm)} ตรม.',
                          )
                        : const SizedBox(),
                    calState.selectedUnit != ConvertingUnit.rai
                        ? ResultRow(
                            resultText:
                                '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.fullRai)} ไร่.',
                          )
                        : const SizedBox(),
                    calState.selectedUnit != ConvertingUnit.ngan
                        ? ResultRow(
                            resultText:
                                '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.fullNgan)} งาน.',
                          )
                        : const SizedBox(),
                    calState.selectedUnit != ConvertingUnit.sqWha
                        ? ResultRow(
                            resultText:
                                '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.fullSqWha)} ตรว.',
                          )
                        : const SizedBox(),
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
                  child: saveState.isNotEmpty
                      ? ListView.builder(
                          itemCount: saveState.length,
                          itemBuilder: (context, index) {
                            final result = saveState[index];
                            return SavedResultRow(
                              resultText: result,
                              deleteFunction: saveNotifier.deleteResult,
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
      ),
    );
  }

  void resetInputCtrl() {
    singleInputCtrl.text = '';
    raiInputCtrl.text = '';
    nganInputCtrl.text = '';
    sqWhaInputCtrl.text = '';
  }
}

String getInputText(
    TextEditingController singleInputCtrl, Calculation calState) {
  if (calState.selectedUnit != ConvertingUnit.raiNganSqWha) {
    return '${singleInputCtrl.text.isNotEmpty ? singleInputCtrl.text : 0} ${getUnitText(calState.selectedUnit)}';
  } else {
    return '${kNumFormat.format(calState.rai)} ไร่ ${kNumFormat.format(calState.ngan)} งาน ${kNumFormat.format(calState.sqWha)} ตรว.';
  }
}
