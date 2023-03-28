import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:convert_rai/features/unit_converter/presentation/component_widgets/custom_input.dart';
import 'package:convert_rai/features/unit_converter/presentation/component_widgets/unit_select_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceConverterPage extends ConsumerStatefulWidget {
  const PriceConverterPage({super.key});

  @override
  PriceConverterPageState createState() => PriceConverterPageState();
}

class PriceConverterPageState extends ConsumerState<PriceConverterPage> {
  final singleInputCtrl = TextEditingController(text: '1');
  final raiInputCtrl = TextEditingController(text: '1');
  final nganInputCtrl = TextEditingController();
  final sqWhaInputCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final calState = ref.watch(calNotifierProvider);
    final calNotifier = ref.watch(calNotifierProvider.notifier);

    return Container(
      color: kBgColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: calState.selectedUnit != ConvertingUnit.raiNganSqWha
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
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
