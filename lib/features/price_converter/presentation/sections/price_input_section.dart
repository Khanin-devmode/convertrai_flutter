import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:convert_rai/shared_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriceInputSection extends StatelessWidget {
  const PriceInputSection(
      {super.key,
      required this.seletedInputUnit,
      required this.singleInputCtrl,
      required this.priceInputCtrl,
      required this.priceCalNotifier,
      required this.seletedOutputUnit,
      required this.raiInputCtrl,
      required this.nganInputCtrl,
      required this.sqWhaInputCtrl,
      required this.selectInputUnit,
      required this.appLocal});

  final ConvertingUnit seletedInputUnit;
  final TextEditingController singleInputCtrl;
  final TextEditingController priceInputCtrl;
  final PriceCalNotifier priceCalNotifier;
  final ConvertingUnit seletedOutputUnit;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
  final Function(ConvertingUnit) selectInputUnit;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            appLocal.unit,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        UnitSelectDropdown(
          selectableUnits: const [
            ConvertingUnit.raiNganSqWha,
            ConvertingUnit.rai,
            ConvertingUnit.ngan,
            ConvertingUnit.sqWha,
            ConvertingUnit.sqm,
          ],
          appLocal: appLocal,
          selectedUnit: seletedInputUnit,
          onChanged: (newUnit) {
            selectInputUnit(newUnit);
            var inputPrice = stringToDouble(priceInputCtrl.text);

            if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
              var unitValue = stringToDouble(singleInputCtrl.text);
              priceCalNotifier.convertPrice(
                  inputPrice, unitValue, seletedInputUnit);
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
        seletedInputUnit != ConvertingUnit.raiNganSqWha
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputLabel(label: appLocal.areaSize),
                  CustomInputField(
                    label: getUnitText(seletedInputUnit, appLocal),
                    inputTextController: singleInputCtrl,
                    onChanged: (newValue) {
                      double unitValue = stringToDouble(newValue);
                      double inputPrice = stringToDouble(priceInputCtrl.text);
                      priceCalNotifier.convertPrice(
                          inputPrice, unitValue, seletedInputUnit);
                    },
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputLabel(label: appLocal.rai),
                        CustomInputField(
                          label: appLocal.rai,
                          inputTextController: raiInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(newValue);
                            double ngan = stringToDouble(nganInputCtrl.text);
                            double sqWha = stringToDouble(sqWhaInputCtrl.text);
                            double inputPrice =
                                stringToDouble(priceInputCtrl.text);
                            priceCalNotifier.convertCombinedUnit(rai, ngan,
                                sqWha, inputPrice, seletedOutputUnit);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputLabel(label: appLocal.ngan),
                        CustomInputField(
                          label: appLocal.ngan,
                          inputTextController: nganInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(raiInputCtrl.text);
                            double ngan = stringToDouble(newValue);
                            double sqWha = stringToDouble(sqWhaInputCtrl.text);
                            double inputPrice =
                                stringToDouble(priceInputCtrl.text);
                            priceCalNotifier.convertCombinedUnit(rai, ngan,
                                sqWha, inputPrice, seletedOutputUnit);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputLabel(label: appLocal.sqWha),
                        CustomInputField(
                          label: appLocal.sqWha,
                          inputTextController: sqWhaInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(raiInputCtrl.text);
                            double ngan = stringToDouble(nganInputCtrl.text);
                            double sqWha = stringToDouble(newValue);
                            double inputPrice =
                                stringToDouble(priceInputCtrl.text);
                            priceCalNotifier.convertCombinedUnit(rai, ngan,
                                sqWha, inputPrice, seletedOutputUnit);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        // Row(
        //   children: [
        //     Expanded(
        //       flex: 4,
        //       child: seletedInputUnit != ConvertingUnit.raiNganSqWha
        //           ? CustomInputField(
        //               label: getUnitText(seletedInputUnit),
        //               inputTextController: singleInputCtrl,
        //               onChanged: (newValue) {
        //                 double unitValue = stringToDouble(newValue);
        //                 double inputPrice = stringToDouble(priceInputCtrl.text);
        //                 priceCalNotifier.convertPrice(
        //                     inputPrice, unitValue, seletedInputUnit);
        //               },
        //             )
        //           : Row(
        //               children: [
        //                 Expanded(
        //                   child: CustomInputField(
        //                     label: 'ไร่',
        //                     inputTextController: raiInputCtrl,
        //                     onChanged: (newValue) {
        //                       double rai = stringToDouble(newValue);
        //                       double ngan = stringToDouble(nganInputCtrl.text);
        //                       double sqWha =
        //                           stringToDouble(sqWhaInputCtrl.text);
        //                       double inputPrice =
        //                           stringToDouble(priceInputCtrl.text);
        //                       priceCalNotifier.convertCombinedUnit(rai, ngan,
        //                           sqWha, inputPrice, seletedOutputUnit);
        //                     },
        //                   ),
        //                 ),
        //                 const SizedBox(width: 12),
        //                 Expanded(
        //                   child: CustomInputField(
        //                     label: 'งาน',
        //                     inputTextController: nganInputCtrl,
        //                     onChanged: (newValue) {
        //                       double rai = stringToDouble(raiInputCtrl.text);
        //                       double ngan = stringToDouble(newValue);
        //                       double sqWha =
        //                           stringToDouble(sqWhaInputCtrl.text);
        //                       double inputPrice =
        //                           stringToDouble(priceInputCtrl.text);
        //                       priceCalNotifier.convertCombinedUnit(rai, ngan,
        //                           sqWha, inputPrice, seletedOutputUnit);
        //                     },
        //                   ),
        //                 ),
        //                 const SizedBox(width: 12),
        //                 Expanded(
        //                   child: CustomInputField(
        //                     label: 'ตรว.',
        //                     inputTextController: sqWhaInputCtrl,
        //                     onChanged: (newValue) {
        //                       double rai = stringToDouble(raiInputCtrl.text);
        //                       double ngan = stringToDouble(nganInputCtrl.text);
        //                       double sqWha = stringToDouble(newValue);
        //                       double inputPrice =
        //                           stringToDouble(priceInputCtrl.text);
        //                       priceCalNotifier.convertCombinedUnit(rai, ngan,
        //                           sqWha, inputPrice, seletedOutputUnit);
        //                     },
        //                   ),
        //                 ),
        //               ],
        //             ),
        //     ),
        //     const SizedBox(
        //       width: 12,
        //     ),
        //     Expanded(
        //       flex: 2,
        //       child: UnitSelectDropdown(
        //         selectableUnits: const [
        //           ConvertingUnit.sqm,
        //           ConvertingUnit.rai,
        //           ConvertingUnit.ngan,
        //           ConvertingUnit.sqWha,
        //           ConvertingUnit.raiNganSqWha
        //         ],
        //         selectedUnit: seletedInputUnit,
        //         onChanged: (newUnit) {
        //           selectInputUnit(newUnit);
        //           var inputPrice = stringToDouble(priceInputCtrl.text);

        //           if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
        //             var unitValue = stringToDouble(singleInputCtrl.text);
        //             priceCalNotifier.convertPrice(
        //                 inputPrice, unitValue, seletedInputUnit);
        //           } else {
        //             double rai = stringToDouble(raiInputCtrl.text);
        //             double ngan = stringToDouble(nganInputCtrl.text);
        //             double sqWha = stringToDouble(sqWhaInputCtrl.text);
        //             double inputPrice = stringToDouble(priceInputCtrl.text);
        //             priceCalNotifier.convertCombinedUnit(
        //                 rai, ngan, sqWha, inputPrice, seletedOutputUnit);
        //           }
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(12),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         flex: 4,
        //         child: CustomInputField(
        //             inputTextController: priceInputCtrl,
        //             onChanged: (newvalue) {
        //               var inputPrice = stringToDouble(newvalue);

        //               if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
        //                 var unitValue = stringToDouble(singleInputCtrl.text);
        //                 priceCalNotifier.convertPrice(
        //                     inputPrice, unitValue, seletedInputUnit);
        //               } else {
        //                 double rai = stringToDouble(raiInputCtrl.text);
        //                 double ngan = stringToDouble(nganInputCtrl.text);
        //                 double sqWha = stringToDouble(sqWhaInputCtrl.text);
        //                 double inputPrice = stringToDouble(priceInputCtrl.text);
        //                 priceCalNotifier.convertCombinedUnit(
        //                     rai, ngan, sqWha, inputPrice, seletedOutputUnit);
        //               }
        //             },
        //             label: 'ราคาที่ดิน'),
        //       ),
        //       // const SizedBox(
        //       //   width: 12,
        //       // ),
        //       // const Expanded(
        //       //   flex: 2,
        //       //   child: Center(
        //       //     child: Text(
        //       //       'บาท',
        //       //       style: kBodyText,
        //       //     ),
        //       //   ),
        //       // )
        //     ],
        //   ),
        // ),
        InputLabel(label: appLocal.price),
        CustomInputField(
          label: appLocal.price,
          inputTextController: priceInputCtrl,
          onChanged: (newvalue) {
            var inputPrice = stringToDouble(newvalue);

            if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
              var unitValue = stringToDouble(singleInputCtrl.text);
              priceCalNotifier.convertPrice(
                  inputPrice, unitValue, seletedInputUnit);
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
      ],
    );
  }
}
