import 'package:convert_rai/features/price_converter/data/price_data_model.dart';
import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:convert_rai/shared_widgets/rai_ngan_sqwa_input.dart';
import 'package:convert_rai/shared_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriceInputSection extends StatelessWidget {
  const PriceInputSection({
    super.key,
    required this.inputAreaUnit,
    required this.singleInputCtrl,
    required this.priceInputCtrl,
    required this.priceCalNotifier,
    required this.seletedOutputUnit,
    required this.raiInputCtrl,
    required this.nganInputCtrl,
    required this.sqWhaInputCtrl,
    required this.selectInputUnit,
    required this.appLocal,
    required this.priceData,
  });

  final ConvertingUnit inputAreaUnit;
  final TextEditingController singleInputCtrl;
  final TextEditingController priceInputCtrl;
  final PriceCalNotifier priceCalNotifier;
  final ConvertingUnit seletedOutputUnit;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
  final Function(ConvertingUnit) selectInputUnit;
  final AppLocalizations appLocal;
  final PriceData priceData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ราคาตั้งต้น',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: inputAreaUnit != ConvertingUnit.raiNganSqWha
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputLabel(label: appLocal.areaSize),
                        CustomTextField(
                          label: getUnitText(inputAreaUnit, appLocal),
                          inputTextController: singleInputCtrl,
                          onChanged: (newValue) {
                            double unitValue = stringToDouble(newValue);
                            double inputPrice =
                                stringToDouble(priceInputCtrl.text);
                            priceCalNotifier.updatePriceData(
                              inputPrice: inputPrice,
                              inputSingleArea: unitValue,
                              inputAreaUnit: inputAreaUnit,
                            );
                          },
                        ),
                      ],
                    )
                  : RaiNganSqwaTextFields(
                      appLocal: appLocal,
                      raiTextCtrl: raiInputCtrl,
                      nganTextCtrl: nganInputCtrl,
                      sqwaTextCtrl: sqWhaInputCtrl,
                      onChanged: (
                        double rai,
                        double ngan,
                        double sqWa,
                      ) {
                        priceCalNotifier.updatePriceData(
                          inputRai: rai,
                          inputNgan: ngan,
                          inputSqWa: sqWa,
                        );
                      },
                    ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Column(
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
                      ConvertingUnit.sqWa,
                      ConvertingUnit.sqm,
                      ConvertingUnit.acre,
                    ],
                    appLocal: appLocal,
                    selectedUnit: priceData.inputAreaUnit,
                    onChanged: (newUnit) {
                      selectInputUnit(newUnit);
                      var inputPrice = stringToDouble(priceInputCtrl.text);

                      if (inputAreaUnit != ConvertingUnit.raiNganSqWha) {
                        var inputArea = stringToDouble(singleInputCtrl.text);
                        priceCalNotifier.updatePriceData(
                          inputPrice: inputPrice,
                          inputSingleArea: inputArea,
                          inputAreaUnit: inputAreaUnit,
                        );
                      } else {
                        double rai = stringToDouble(raiInputCtrl.text);
                        double ngan = stringToDouble(nganInputCtrl.text);
                        double sqWha = stringToDouble(sqWhaInputCtrl.text);
                        priceCalNotifier.updatePriceData(
                          inputRai: rai,
                          inputNgan: ngan,
                          inputSqWa: sqWha,
                          inputAreaUnit: inputAreaUnit,
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        InputLabel(label: appLocal.price),
        CustomTextField(
          label: appLocal.price,
          inputTextController: priceInputCtrl,
          onChanged: (newvalue) {
            var inputPrice = stringToDouble(newvalue);
            priceCalNotifier.updatePriceData(
              inputPrice: inputPrice,
            );

            // if (inputAreaUnit != ConvertingUnit.raiNganSqWha) {
            //   var inputArea = stringToDouble(singleInputCtrl.text);
            //   priceCalNotifier.updatePriceData(
            //     inputPrice: inputPrice,
            //     inputArea: inputArea,
            //     inputAreaUnit: inputAreaUnit,
            //   );
            // } else {
            //   double rai = stringToDouble(raiInputCtrl.text);
            //   double ngan = stringToDouble(nganInputCtrl.text);
            //   double sqWha = stringToDouble(sqWhaInputCtrl.text);
            //   double inputPrice = stringToDouble(priceInputCtrl.text);
            //   priceCalNotifier.convertCombinedUnit(
            //     rai: rai,
            //     ngan: ngan,
            //     sqWa: sqWha,
            //     inputPrice: inputPrice
            //   );
            // }
          },
        ),
      ],
    );
  }
}
