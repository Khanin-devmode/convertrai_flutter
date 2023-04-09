import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/unit_converter/domain/saving_logic.dart';
import 'package:convert_rai/shared_widgets/saved_result_row.dart';
import 'package:flutter/material.dart';

class SaveResultArea extends StatelessWidget {
  const SaveResultArea({
    super.key,
    required this.saveState,
    required this.saveNotifier,
  });

  final List<String> saveState;
  final SaveNotifier saveNotifier;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: saveState.isNotEmpty
            ? ListView.builder(
                itemCount: saveState.length,
                itemBuilder: (context, index) {
                  final result = saveState[index];
                  return SavedResultRow(
                    resultText: result,
                    deleteFunction: saveNotifier.deleteResult,
                    index: index,
                  );
                })
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("กด"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.save_outlined,
                        color: kIconColor,
                      ),
                    ),
                    Text("เพื่อบันทึกผลแปลงหน่วยที่นี่")
                  ],
                ),
              ),
      ),
    );
  }
}

class SaveResultAreaHeader extends StatelessWidget {
  const SaveResultAreaHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(children: [
        Container(
            padding: const EdgeInsets.only(left: 16, top: 16),
            alignment: Alignment.topLeft,
            child: const Text(
              'บันทึกผล',
              style: kSecondTitleTextStyle,
            )),
      ]),
    );
  }
}
