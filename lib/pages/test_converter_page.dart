import 'package:convert_rai/calculate_logic.dart';
import 'package:convert_rai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestConverterPage extends ConsumerStatefulWidget {
  const TestConverterPage({super.key});

  @override
  TestConverterPageState createState() => TestConverterPageState();
}

class TestConverterPageState extends ConsumerState<TestConverterPage> {
  @override
  Widget build(BuildContext context) {
    final calState = ref.watch(calNotifierProvider);
    final calNotifier = ref.watch(calNotifierProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBgColor,
          elevation: 0,
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                flex: 6,
                child: Text(
                  'Convert Rai',
                  style: kTitleTextStyle,
                ),
              ),
              Flexible(
                flex: 6,
                child: Container(
                  height: 8,
                  decoration: const BoxDecoration(
                    color: kTitleColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: kBgColor,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
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
                  ),
                  DropdownButton<ConvertingUnit>(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    alignment: Alignment.center,
                    value: calState.selectedUnit,
                    items: ConvertingUnit.values.map((ConvertingUnit unit) {
                      return DropdownMenuItem<ConvertingUnit>(
                          value: unit, child: Text(unit.toString()));
                    }).toList(),
                    onChanged: (newUnit) => calNotifier.selectUnit(newUnit),
                  ),
                ],
              ),
              Text('${calState.sqm} ตรม.'),
              Text('${calState.fullNgan} งาน.'),
              Text('${calState.fullSqWha} ตรว.'),
              Text('${calState.selectedUnit}')
            ],
          ),
        ),
      ),
    );
  }
}
