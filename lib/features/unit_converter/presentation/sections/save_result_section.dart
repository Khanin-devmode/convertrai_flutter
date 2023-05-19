import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/unit_converter/domain/saving_logic.dart';
import 'package:convert_rai/shared_widgets/saved_result_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveResultArea extends StatelessWidget {
  const SaveResultArea(
      {super.key,
      required this.saveState,
      required this.saveNotifier,
      required this.appLocal});

  final List<String> saveState;
  final SaveNotifier saveNotifier;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: saveState.isNotEmpty
          ? Column(
              children: List.generate(
                  saveState.length,
                  (i) => SavedResultRow(
                        resultText: saveState[i],
                        deleteFunction: saveNotifier.deleteResult,
                        index: i,
                      )),
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(appLocal.press),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.save_outlined,
                      color: kIconColor,
                    ),
                  ),
                  Text(appLocal.saveResultHere)
                ],
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
