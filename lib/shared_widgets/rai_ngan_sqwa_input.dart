import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:flutter/material.dart';
import '../features/unit_converter/presentation/helper_function.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RaiNganSqwaTextFields extends StatelessWidget {
  const RaiNganSqwaTextFields({
    super.key,
    required this.appLocal,
    required this.raiTextCtrl,
    required this.nganTextCtrl,
    required this.sqwaTextCtrl,
    this.onChanged,
  });

  final AppLocalizations appLocal;
  final TextEditingController raiTextCtrl;
  final TextEditingController nganTextCtrl;
  final TextEditingController sqwaTextCtrl;
  final Function(double rai, double ngan, double sqwa)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(label: appLocal.rai),
              CustomTextField(
                label: appLocal.rai,
                inputTextController: raiTextCtrl,
                onChanged: (newValue) {
                  double rai = stringToDouble(newValue);
                  double ngan = stringToDouble(nganTextCtrl.text);
                  double sqWha = stringToDouble(sqwaTextCtrl.text);
                  // priceCalNotifier.convertCombinedUnit(
                  //   rai: rai,
                  //   ngan: ngan,
                  //   sqWha: sqWha,
                  // );
                  onChanged!(rai, ngan, sqWha);
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(label: appLocal.ngan),
              CustomTextField(
                label: appLocal.ngan,
                inputTextController: nganTextCtrl,
                onChanged: (newValue) {
                  double rai = stringToDouble(raiTextCtrl.text);
                  double ngan = stringToDouble(newValue);
                  double sqWha = stringToDouble(sqwaTextCtrl.text);
                  // priceCalNotifier.convertCombinedUnit(
                  //   rai: rai,
                  //   ngan: ngan,
                  //   sqWha: sqWha,
                  // );
                  onChanged!(rai, ngan, sqWha);
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(label: appLocal.sqWa),
              CustomTextField(
                label: appLocal.sqWa,
                inputTextController: sqwaTextCtrl,
                onChanged: (newValue) {
                  double rai = stringToDouble(raiTextCtrl.text);
                  double ngan = stringToDouble(nganTextCtrl.text);
                  double sqWha = stringToDouble(newValue);
                  // priceCalNotifier.convertCombinedUnit(
                  //   rai: rai,
                  //   ngan: ngan,
                  //   sqWha: sqWha,
                  // );
                  onChanged!(rai, ngan, sqWha);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
