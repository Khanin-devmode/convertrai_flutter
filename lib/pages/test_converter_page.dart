import 'package:convert_rai/calculate_logic.dart';
import 'package:convert_rai/components/result_row.dart';
import 'package:convert_rai/components/snackbar.dart';
import 'package:convert_rai/constants.dart';
import 'package:convert_rai/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class TestConverterPage extends ConsumerStatefulWidget {
  const TestConverterPage({super.key});

  @override
  TestConverterPageState createState() => TestConverterPageState();
}

class TestConverterPageState extends ConsumerState<TestConverterPage> {
  final inputTextController = TextEditingController();

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
                      child: TextField(
                        controller: inputTextController,
                        onChanged: (newValue) {
                          double n = stringToDouble(newValue);
                          calNotifier.convertUnit(n);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [ThousandsFormatter()],
                        decoration: InputDecoration(
                          // label: Text(label),
                          hintText: 'label',
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
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: DropdownButton<ConvertingUnit>(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          alignment: Alignment.center,
                          value: calState.selectedUnit,
                          items:
                              ConvertingUnit.values.map((ConvertingUnit unit) {
                            return DropdownMenuItem<ConvertingUnit>(
                                value: unit, child: Text(getUnitText(unit)));
                          }).toList(),
                          onChanged: (newUnit) {
                            calNotifier.selectUnit(newUnit);
                            double n = stringToDouble(inputTextController.text);
                            calNotifier.convertUnit(n);
                          },
                        ),
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
                    ResultRow(
                      resultText:
                          '${inputTextController.text} ${getUnitText(calState.selectedUnit)} = ${kNumFormat.format(calState.sqm)} ตรม.',
                    ),
                    ResultRow(
                      resultText:
                          '${inputTextController.text} ${getUnitText(calState.selectedUnit)} = ${kNumFormat.format(calState.fullRai)} ไร่.',
                    ),
                    ResultRow(
                      resultText:
                          '${inputTextController.text} ${getUnitText(calState.selectedUnit)} = ${kNumFormat.format(calState.fullNgan)} งาน.',
                    ),
                    ResultRow(
                      resultText:
                          '${inputTextController.text} ${getUnitText(calState.selectedUnit)} = ${kNumFormat.format(calState.fullSqWha)} ตรว.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
