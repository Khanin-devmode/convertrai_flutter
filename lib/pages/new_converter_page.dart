import 'package:convert_rai/calculate_logic.dart';
import 'package:convert_rai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewConverterPage extends ConsumerStatefulWidget {
  const NewConverterPage({super.key});

  @override
  _NewConverterPageState createState() => _NewConverterPageState();
}

class _NewConverterPageState extends ConsumerState<NewConverterPage> {
  @override
  Widget build(BuildContext context) {
    final calculator = ref.watch(calcProvider);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('${calculator.sqm}'),
              TextField(
                inputFormatters: kNumberInputFormatter,
                onChanged: (newValue) {
                  var pureNum = newValue.replaceAll(RegExp('[^A-Za-z0-9]'), '');
                  double n = double.parse(pureNum);
                  calculator.convertUnit(n);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
