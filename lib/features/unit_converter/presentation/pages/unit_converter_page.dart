import 'package:convert_rai/features/unit_converter/presentation/cubit/save_result_cubit.dart';
import 'package:convert_rai/features/unit_converter/presentation/cubit/save_result_state.dart';
import 'package:convert_rai/features/unit_converter/presentation/cubit/unit_converter_cubit.dart';
import 'package:convert_rai/features/unit_converter/presentation/cubit/unit_converter_state.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/input_unit_section.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/output_unit_section.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/save_result_section.dart';
import 'package:convert_rai/shared_widgets/header_label.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:convert_rai/l10n/app_localizations.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  ConverterPageState createState() => ConverterPageState();
}

class ConverterPageState extends State<UnitConverterPage> {
  @override
  void initState() {
    super.initState();
    context.read<SaveResultCubit>().initHiveSavingBox();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context)!;

    return BlocBuilder<UnitConverterCubit, UnitConverterState>(builder: (context, unitState) {
      return BlocBuilder<SaveResultCubit, SaveResultState>(builder: (context, saveState) {
        final calState = unitState.calculation;
        final singleInputCtrl = unitState.singleInputCtrl;
        final raiInputCtrl = unitState.raiInputCtrl;
        final nganInputCtrl = unitState.nganInputCtrl;
        final sqWhaInputCtrl = unitState.sqWhaInputCtrl;

        return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderRow(label: appLocal.areaUnitConverter),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            padding:
                const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
            decoration: const BoxDecoration(
                color: Color(
                  0xFFF6F5F1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputLabel(label: appLocal.inputArea),
                InputSection(
                  calState: calState,
                  singleInputCtrl: singleInputCtrl,
                  raiInputCtrl: raiInputCtrl,
                  nganInputCtrl: nganInputCtrl,
                  sqWhaInputCtrl: sqWhaInputCtrl,
                  appLocal: appLocal,
                ),
                const Divider(
                  height: 40,
                ),
                InputLabel(
                  label: appLocal.allResult,
                ),
                OutputUnitSection(
                  calState: calState,
                  singleInputCtrl: singleInputCtrl,
                  raiInputCtrl: raiInputCtrl,
                  nganInputCtrl: nganInputCtrl,
                  sqWhaInputCtrl: sqWhaInputCtrl,
                  appLocal: appLocal,
                ),
                InputLabel(
                  label: appLocal.saveResult,
                ),
                const SizedBox(
                  height: 10,
                ),
                SaveResultArea(
                  saveState: saveState.savedResults,
                  appLocal: appLocal,
                ),
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
    });
  }
}
