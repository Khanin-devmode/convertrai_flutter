import 'package:auto_size_text/auto_size_text.dart';
import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/price_converter/presentation/cubit/price_converter_cubit.dart';
import 'package:convert_rai/features/price_converter/presentation/cubit/price_converter_state.dart';
import 'package:convert_rai/features/price_converter/presentation/sections/price_input_section.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/shared_widgets/header_label.dart';
import 'package:convert_rai/shared_widgets/rai_ngan_sqwa_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convert_rai/l10n/app_localizations.dart';

import '../../../../shared_widgets/custom_input.dart';
import '../../../../shared_widgets/input_label.dart';
import '../../../../shared_widgets/unit_select_dropdown.dart';
import '../../../../shared/helper_functions.dart';

class PriceConverterPage extends StatefulWidget {
  const PriceConverterPage({super.key});

  @override
  PriceConverterPageState createState() => PriceConverterPageState();
}

class PriceConverterPageState extends State<PriceConverterPage> {
  ConvertingUnit seletedInputUnit = ConvertingUnit.sqWa;
  ConvertingUnit seletedOutputUnit = ConvertingUnit.rai;

  final outputAreaController = TextEditingController(text: '1');

  selectInputUnit(ConvertingUnit unit) {
    setState(() {
      seletedInputUnit = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;

    return BlocBuilder<PriceConverterCubit, PriceConverterState>(builder: (context, priceState) {
      final priceData = priceState.priceData;
      final singleInputCtrl = priceState.singleInputCtrl;
      final raiInputCtrl = priceState.raiInputCtrl;
      final nganInputCtrl = priceState.nganInputCtrl;
      final sqwaInputCtrl = priceState.sqWhaInputCtrl;
      final priceInputCtrl = priceState.priceInputCtrl;

      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderRow(label: appLocal.priceConverter),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding:
                const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
            decoration: const BoxDecoration(
              color: Color(
                0xFFF6F5F1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PriceInputSection(
                  inputAreaUnit: seletedInputUnit,
                  singleInputCtrl: singleInputCtrl,
                  priceInputCtrl: priceInputCtrl,
                  seletedOutputUnit: seletedOutputUnit,
                  raiInputCtrl: raiInputCtrl,
                  nganInputCtrl: nganInputCtrl,
                  sqWhaInputCtrl: sqwaInputCtrl,
                  selectInputUnit: selectInputUnit,
                  appLocal: appLocal,
                  priceData: priceData,
                ),
                const Divider(
                  height: 40,
                ),
                // Text(
                //   appLocal.pricePerUnit,
                //   style: const TextStyle(fontSize: 20),
                // ),

                InputLabel(label: appLocal.targetAreaPrice),

                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: seletedOutputUnit != ConvertingUnit.raiNganSqWha
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InputLabel(label: appLocal.areaSize),
                                CustomTextField(
                                  label:
                                      getUnitText(seletedOutputUnit, appLocal),
                                  inputTextController: outputAreaController,
                                  onChanged: (newValue) {
                                    double outputArea =
                                        stringToDouble(newValue);

                                    context.read<PriceConverterCubit>().updatePriceData(
                                      outputSingleArea: outputArea,
                                    );
                                  },
                                ),
                              ],
                            )
                          : RaiNganSqwaTextFields(
                              appLocal: appLocal,
                              raiTextCtrl: priceState.raiOutputCtrl,
                              nganTextCtrl: priceState.nganOutputCtrl,
                              sqwaTextCtrl: priceState.sqWhaOutputCtrl,
                              onChanged: (rai, ngan, sqwa) {
                                context.read<PriceConverterCubit>().updatePriceData(
                                  outputRai: rai,
                                  outputNgan: ngan,
                                  outputSqWa: sqwa,
                                );
                              },
                            ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputLabel(label: appLocal.unit),
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
                            selectedUnit: seletedOutputUnit,
                            onChanged: (newUnit) {
                              setState(() {
                                seletedOutputUnit = newUnit;

                                if (seletedOutputUnit !=
                                    ConvertingUnit.raiNganSqWha) {
                                  context.read<PriceConverterCubit>().updatePriceData(
                                    outputAreaUnit: newUnit,
                                  );
                                } else {
                                  double rai = stringToDouble(
                                      priceState.raiOutputCtrl.text);
                                  double ngan = stringToDouble(
                                      priceState.nganOutputCtrl.text);
                                  double sqwa = stringToDouble(
                                      priceState.sqWhaOutputCtrl.text);

                                  context.read<PriceConverterCubit>().updatePriceData(
                                    outputRai: rai,
                                    outputNgan: ngan,
                                    outputSqWa: sqwa,
                                    outputAreaUnit: seletedOutputUnit,
                                  );
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                InputLabel(label: appLocal.price),
                Container(
                  constraints: BoxConstraints(minHeight: 100),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: AutoSizeText(
                          '${kBahtFormat.format(priceData.getOutputPrice())} ${appLocal.baht}',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ),
                    ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 80,
        )
      ],
    );
    });
  }
}
