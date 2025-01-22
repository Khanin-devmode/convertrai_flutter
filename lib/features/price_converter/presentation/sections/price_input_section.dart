import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
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
            ConvertingUnit.acre,
          ],
          appLocal: appLocal,
          selectedUnit: inputAreaUnit,
          onChanged: (newUnit) {
            selectInputUnit(newUnit);
            var inputPrice = stringToDouble(priceInputCtrl.text);

            if (inputAreaUnit != ConvertingUnit.raiNganSqWha) {
              var inputArea = stringToDouble(singleInputCtrl.text);
              priceCalNotifier.updatePriceData(
                inputPrice: inputPrice,
                inputArea: inputArea,
                inputAreaUnit: inputAreaUnit,
              );
            } else {
              double rai = stringToDouble(raiInputCtrl.text);
              double ngan = stringToDouble(nganInputCtrl.text);
              double sqWha = stringToDouble(sqWhaInputCtrl.text);
              double inputPrice = stringToDouble(priceInputCtrl.text);
              priceCalNotifier.convertCombinedUnit(
                rai: rai,
                ngan: ngan,
                sqWha: sqWha,
                inputPrice: inputPrice,
              );
            }
          },
        ),
        inputAreaUnit != ConvertingUnit.raiNganSqWha
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputLabel(label: appLocal.areaSize),
                  CustomInputField(
                    label: getUnitText(inputAreaUnit, appLocal),
                    inputTextController: singleInputCtrl,
                    onChanged: (newValue) {
                      double unitValue = stringToDouble(newValue);
                      double inputPrice = stringToDouble(priceInputCtrl.text);
                      priceCalNotifier.updatePriceData(
                        inputPrice: inputPrice,
                        inputArea: unitValue,
                        inputAreaUnit: inputAreaUnit,
                      );
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
                            priceCalNotifier.convertCombinedUnit(
                              rai: rai,
                              ngan: ngan,
                              sqWha: sqWha,
                              inputPrice: inputPrice,
                            );
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
                            priceCalNotifier.convertCombinedUnit(
                              rai: rai,
                              ngan: ngan,
                              sqWha: sqWha,
                              inputPrice: inputPrice,
                            );
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
                            priceCalNotifier.convertCombinedUnit(
                              rai: rai,
                              ngan: ngan,
                              sqWha: sqWha,
                              inputPrice: inputPrice,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        InputLabel(label: appLocal.price),
        CustomInputField(
          label: appLocal.price,
          inputTextController: priceInputCtrl,
          onChanged: (newvalue) {
            var inputPrice = stringToDouble(newvalue);

            if (inputAreaUnit != ConvertingUnit.raiNganSqWha) {
              var inputArea = stringToDouble(singleInputCtrl.text);
              priceCalNotifier.updatePriceData(
                  inputPrice: inputPrice,
                  inputArea: inputArea,
                  inputAreaUnit: inputAreaUnit);
            } else {
              double rai = stringToDouble(raiInputCtrl.text);
              double ngan = stringToDouble(nganInputCtrl.text);
              double sqWha = stringToDouble(sqWhaInputCtrl.text);
              double inputPrice = stringToDouble(priceInputCtrl.text);
              priceCalNotifier.convertCombinedUnit(
                rai: rai,
                ngan: ngan,
                sqWha: sqWha,
                inputPrice: inputPrice,
              );
            }
          },
        ),
      ],
    );
  }
}
