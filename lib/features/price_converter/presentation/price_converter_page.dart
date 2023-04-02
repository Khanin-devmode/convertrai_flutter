import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/component_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:convert_rai/features/unit_converter/presentation/component_widgets/custom_input.dart';
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
  final priceInputCtrl = TextEditingController();

  ConvertingUnit seletedInputUnit = ConvertingUnit.rai;
  ConvertingUnit seletedOutputUnit = ConvertingUnit.rai;

  @override
  Widget build(BuildContext context) {
    final priceCalState = ref.watch(priceCalNotifierProvider);
    final priceCalNotifier = ref.watch(priceCalNotifierProvider.notifier);

    return Container(
      color: kBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'ขนาดและราคาที่ดิน',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: seletedInputUnit != ConvertingUnit.raiNganSqWha
                      ? CustomInputField(
                          label: getUnitText(seletedInputUnit),
                          inputTextController: singleInputCtrl,
                          onChanged: (newValue) {
                            double unitValue = stringToDouble(newValue);
                            double inputPrice =
                                stringToDouble(priceInputCtrl.text);
                            priceCalNotifier.convertPrice(inputPrice, unitValue,
                                seletedInputUnit, seletedOutputUnit);
                          },
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: CustomInputField(
                                label: 'ไร่',
                                inputTextController: raiInputCtrl,
                                onChanged: (newValue) {
                                  double rai = stringToDouble(newValue);
                                  double ngan =
                                      stringToDouble(nganInputCtrl.text);
                                  double sqWha =
                                      stringToDouble(sqWhaInputCtrl.text);
                                  double inputPrice =
                                      stringToDouble(priceInputCtrl.text);
                                  priceCalNotifier.convertCombinedUnit(
                                      rai,
                                      ngan,
                                      sqWha,
                                      inputPrice,
                                      seletedOutputUnit);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomInputField(
                                label: 'งาน',
                                inputTextController: nganInputCtrl,
                                onChanged: (newValue) {
                                  double rai =
                                      stringToDouble(raiInputCtrl.text);
                                  double ngan = stringToDouble(newValue);
                                  double sqWha =
                                      stringToDouble(sqWhaInputCtrl.text);
                                  double inputPrice =
                                      stringToDouble(priceInputCtrl.text);
                                  priceCalNotifier.convertCombinedUnit(
                                      rai,
                                      ngan,
                                      sqWha,
                                      inputPrice,
                                      seletedOutputUnit);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomInputField(
                                label: 'ตรว.',
                                inputTextController: sqWhaInputCtrl,
                                onChanged: (newValue) {
                                  double rai =
                                      stringToDouble(raiInputCtrl.text);
                                  double ngan =
                                      stringToDouble(nganInputCtrl.text);
                                  double sqWha = stringToDouble(newValue);
                                  double inputPrice =
                                      stringToDouble(priceInputCtrl.text);
                                  priceCalNotifier.convertCombinedUnit(
                                      rai,
                                      ngan,
                                      sqWha,
                                      inputPrice,
                                      seletedOutputUnit);
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
                    selectableUnits: const [
                      ConvertingUnit.sqm,
                      ConvertingUnit.rai,
                      ConvertingUnit.ngan,
                      ConvertingUnit.sqWha,
                      ConvertingUnit.raiNganSqWha
                    ],
                    selectedUnit: seletedInputUnit,
                    onChanged: (newUnit) {
                      setState(() {
                        seletedInputUnit = newUnit;
                      });
                      var inputPrice = stringToDouble(priceInputCtrl.text);

                      if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
                        var unitValue = stringToDouble(singleInputCtrl.text);
                        priceCalNotifier.convertPrice(inputPrice, unitValue,
                            seletedInputUnit, seletedOutputUnit);
                      } else {
                        double rai = stringToDouble(raiInputCtrl.text);
                        double ngan = stringToDouble(nganInputCtrl.text);
                        double sqWha = stringToDouble(sqWhaInputCtrl.text);
                        double inputPrice = stringToDouble(priceInputCtrl.text);
                        priceCalNotifier.convertCombinedUnit(
                            rai, ngan, sqWha, inputPrice, seletedOutputUnit);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: CustomInputField(
                inputTextController: priceInputCtrl,
                onChanged: (newvalue) {
                  var inputPrice = stringToDouble(newvalue);

                  if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
                    var unitValue = stringToDouble(singleInputCtrl.text);
                    priceCalNotifier.convertPrice(inputPrice, unitValue,
                        seletedInputUnit, seletedOutputUnit);
                  } else {
                    double rai = stringToDouble(raiInputCtrl.text);
                    double ngan = stringToDouble(nganInputCtrl.text);
                    double sqWha = stringToDouble(sqWhaInputCtrl.text);
                    double inputPrice = stringToDouble(priceInputCtrl.text);
                    priceCalNotifier.convertCombinedUnit(
                        rai, ngan, sqWha, inputPrice, seletedOutputUnit);
                  }
                },
                label: 'ราคาที่ดิน'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ราคาต่อหน่วย',
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  width: 120,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: UnitSelectDropdown(
                    selectableUnits: const [
                      ConvertingUnit.sqm,
                      ConvertingUnit.rai,
                      ConvertingUnit.ngan,
                      ConvertingUnit.sqWha,
                    ],
                    selectedUnit: seletedOutputUnit,
                    onChanged: (newUnit) {
                      setState(() {
                        seletedOutputUnit = newUnit;
                      });
                      var inputPrice = stringToDouble(priceInputCtrl.text);

                      if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
                        var unitValue = stringToDouble(singleInputCtrl.text);
                        priceCalNotifier.convertPrice(inputPrice, unitValue,
                            seletedInputUnit, seletedOutputUnit);
                      } else {
                        double rai = stringToDouble(raiInputCtrl.text);
                        double ngan = stringToDouble(nganInputCtrl.text);
                        double sqWha = stringToDouble(sqWhaInputCtrl.text);
                        double inputPrice = stringToDouble(priceInputCtrl.text);
                        priceCalNotifier.convertCombinedUnit(
                            rai, ngan, sqWha, inputPrice, seletedOutputUnit);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${getUnitText(seletedOutputUnit)} ละ',
                    style: kBodyText,
                  ),
                  Text(
                    priceCalState.toString(),
                    style: TextStyle(fontSize: 48),
                  ),
                  const Text(
                    'บาท',
                    style: kBodyText,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
