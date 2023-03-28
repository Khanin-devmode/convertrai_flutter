import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/features/unit_converter/presentation/area_widgets/input_area.dart';
import 'package:convert_rai/features/unit_converter/presentation/area_widgets/result_area.dart';
import 'package:convert_rai/features/unit_converter/presentation/area_widgets/save_result_area.dart';
import 'package:convert_rai/features/unit_converter/domain/saving_logic.dart';
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
      children: [
        InputArea(
            calState: calState,
            singleInputCtrl: singleInputCtrl,
            calNotifier: calNotifier,
            raiInputCtrl: raiInputCtrl,
            nganInputCtrl: nganInputCtrl,
            sqWhaInputCtrl: sqWhaInputCtrl),
        ResultArea(calState: calState, singleInputCtrl: singleInputCtrl),
        const SaveResultAreaHeader(),
        SaveResultArea(saveState: saveState, saveNotifier: saveNotifier),
      ],
    );
  }
}
