import 'package:convert_rai/calculate_logic.dart';
import 'package:convert_rai/components/result_row.dart';
import 'package:convert_rai/constants.dart';
import 'package:convert_rai/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class TestConverterPage extends ConsumerStatefulWidget {
  const TestConverterPage({super.key});

  @override
  TestConverterPageState createState() => TestConverterPageState();
}

class TestConverterPageState extends ConsumerState<TestConverterPage> {
  final singleInputCtrl = TextEditingController(text: '1');
  final raiInputCtrl = TextEditingController(text: '1');
  final nganInputCtrl = TextEditingController();
  final sqWhaInputCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final calState = ref.watch(calNotifierProvider);
    final calNotifier = ref.watch(calNotifierProvider.notifier);

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

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {super.key,
      required this.inputTextController,
      required this.calNotifier,
      required this.onChanged,
      required this.label});

  final TextEditingController inputTextController;
  final CalNotifier calNotifier;
  final Function(String) onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputTextController,
      onChanged: onChanged,
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
    );
  }
}

class UnitSelectDropdown extends StatelessWidget {
  const UnitSelectDropdown(
      {super.key,
      required this.calState,
      required this.calNotifier,
      required this.singleInputCtrl,
      required this.raiInputCtrl,
      required this.nganInputCtrl,
      required this.sqWhaInputCtrl});

  final Calculation calState;
  final CalNotifier calNotifier;
  final TextEditingController singleInputCtrl;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: DropdownButton<ConvertingUnit>(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        alignment: Alignment.center,
        value: calState.selectedUnit,
        items: ConvertingUnit.values.map((ConvertingUnit unit) {
          return DropdownMenuItem<ConvertingUnit>(
              value: unit, child: Text(getUnitText(unit)));
        }).toList(),
        onChanged: (newUnit) {
          calNotifier.selectUnit(newUnit);

          if (newUnit != ConvertingUnit.raiNganSqWha) {
            double n = stringToDouble(singleInputCtrl.text);
            calNotifier.convertUnit(n);
          } else {
            double rai = stringToDouble(raiInputCtrl.text);
            double ngan = stringToDouble(nganInputCtrl.text);
            double sqWha = stringToDouble(sqWhaInputCtrl.text);
            calNotifier.convertCombinedUnit(rai, ngan, sqWha);
          }
        },
      ),
    );
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
