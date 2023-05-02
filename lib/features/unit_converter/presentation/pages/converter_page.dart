import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/input_unit_section.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/output_unit_section.dart';
import 'package:convert_rai/features/unit_converter/presentation/sections/save_result_section.dart';
import 'package:convert_rai/features/unit_converter/domain/saving_logic.dart';
import 'package:convert_rai/shared_widgets/header_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConverterPage extends ConsumerStatefulWidget {
  const ConverterPage({super.key});

  @override
  ConverterPageState createState() => ConverterPageState();
}

class ConverterPageState extends ConsumerState<ConverterPage> {
  final singleInputCtrl = TextEditingController(text: '1');
  final raiInputCtrl = TextEditingController(text: '1');
  final nganInputCtrl = TextEditingController();
  final sqWhaInputCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final calState = ref.watch(calNotifierProvider);
    final calNotifier = ref.watch(calNotifierProvider.notifier);
    final List<String> saveState = ref.watch(saveNotifierProvider);
    final saveNotifier = ref.watch(saveNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderLabel(label: 'Unit Converter'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              decoration: const BoxDecoration(
                  color: Color(
                    0xFFF6F5F1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: Column(
                children: [
                  InputSection(
                      calState: calState,
                      singleInputCtrl: singleInputCtrl,
                      calNotifier: calNotifier,
                      raiInputCtrl: raiInputCtrl,
                      nganInputCtrl: nganInputCtrl,
                      sqWhaInputCtrl: sqWhaInputCtrl),
                  const Divider(
                    height: 40,
                  ),
                  OutputUnitSection(
                    calState: calState,
                    singleInputCtrl: singleInputCtrl,
                    raiInputCtrl: raiInputCtrl,
                    nganInputCtrl: nganInputCtrl,
                    sqWhaInputCtrl: sqWhaInputCtrl,
                  ),
                  const SaveResultAreaHeader(),
                  SaveResultArea(
                      saveState: saveState, saveNotifier: saveNotifier),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
