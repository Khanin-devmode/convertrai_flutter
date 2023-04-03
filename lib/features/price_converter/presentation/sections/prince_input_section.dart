import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/component_widgets/custom_input.dart';
import 'package:convert_rai/features/unit_converter/presentation/component_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';

class PriceInputSection extends StatelessWidget {
  const PriceInputSection({
    super.key,
    required this.seletedInputUnit,
    required this.singleInputCtrl,
    required this.priceInputCtrl,
    required this.priceCalNotifier,
    required this.seletedOutputUnit,
    required this.raiInputCtrl,
    required this.nganInputCtrl,
    required this.sqWhaInputCtrl,
    required this.selectInputUnit,
  });

  final ConvertingUnit seletedInputUnit;
  final TextEditingController singleInputCtrl;
  final TextEditingController priceInputCtrl;
  final PriceCalNotifier priceCalNotifier;
  final ConvertingUnit seletedOutputUnit;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
  final Function(ConvertingUnit) selectInputUnit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
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
                                priceCalNotifier.convertCombinedUnit(rai, ngan,
                                    sqWha, inputPrice, seletedOutputUnit);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomInputField(
                              label: 'งาน',
                              inputTextController: nganInputCtrl,
                              onChanged: (newValue) {
                                double rai = stringToDouble(raiInputCtrl.text);
                                double ngan = stringToDouble(newValue);
                                double sqWha =
                                    stringToDouble(sqWhaInputCtrl.text);
                                double inputPrice =
                                    stringToDouble(priceInputCtrl.text);
                                priceCalNotifier.convertCombinedUnit(rai, ngan,
                                    sqWha, inputPrice, seletedOutputUnit);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomInputField(
                              label: 'ตรว.',
                              inputTextController: sqWhaInputCtrl,
                              onChanged: (newValue) {
                                double rai = stringToDouble(raiInputCtrl.text);
                                double ngan =
                                    stringToDouble(nganInputCtrl.text);
                                double sqWha = stringToDouble(newValue);
                                double inputPrice =
                                    stringToDouble(priceInputCtrl.text);
                                priceCalNotifier.convertCombinedUnit(rai, ngan,
                                    sqWha, inputPrice, seletedOutputUnit);
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
                    selectInputUnit(newUnit);
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
          child: Row(
            children: [
              Expanded(
                flex: 4,
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
              // const SizedBox(
              //   width: 12,
              // ),
              // const Expanded(
              //   flex: 2,
              //   child: Center(
              //     child: Text(
              //       'บาท',
              //       style: kBodyText,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
