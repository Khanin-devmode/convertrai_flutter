import 'package:convert_rai/calculate_logic.dart';
import 'package:convert_rai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewConverterPage extends ConsumerStatefulWidget {
  const NewConverterPage({super.key});

  @override
  NewConverterPageState createState() => NewConverterPageState();
}

class NewConverterPageState extends ConsumerState<NewConverterPage> {
  @override
  Widget build(BuildContext context) {
    final calState = ref.watch(calNotifierProvider);
    final calNotifier = ref.watch(calNotifierProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('${calState.sqm}'),
              TextField(
                inputFormatters: kNumberInputFormatter,
                onChanged: (newValue) {
                  String pureNum =
                      newValue.replaceAll(RegExp('[^A-Za-z0-9]'), '');
                  double n;
                  if (pureNum.isNotEmpty) {
                    n = double.parse(pureNum);
                  } else {
                    n = 0;
                  }
                  calNotifier.convertUnit(n);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
