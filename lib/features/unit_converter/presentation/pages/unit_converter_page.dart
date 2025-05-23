import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/input_unit_section.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/output_unit_section.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/save_result_section.dart';
import 'package:convert_rai/features/unit_converter/domain/saving_logic.dart';
import 'package:convert_rai/shared_widgets/header_label.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnitConverterPage extends ConsumerStatefulWidget {
  const UnitConverterPage({super.key});

  @override
  ConverterPageState createState() => ConverterPageState();
}

class ConverterPageState extends ConsumerState<UnitConverterPage> {
  @override
  void initState() {
    ref.read(saveNotifierProvider.notifier).initHiveSavingBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final calState = ref.watch(calNotifierProvider);
    final calNotifier = ref.watch(calNotifierProvider.notifier);
    final List<String> saveState = ref.watch(saveNotifierProvider);
    final saveNotifier = ref.watch(saveNotifierProvider.notifier);
    final singleInputCtrl = ref.watch(singleInputCtrlProviderUnitCon);
    final raiInputCtrl = ref.watch(raiInputCtrlProviderUnitCon);
    final nganInputCtrl = ref.watch(nganInputCtrlProviderUnitCon);
    final sqWhaInputCtrl = ref.watch(sqWhaInputCtrlProviderUnitCon);

    final appLocal = AppLocalizations.of(context)!;

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
                  areaCalNotifier: calNotifier,
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
                  saveState: saveState,
                  saveNotifier: saveNotifier,
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
  }
}
