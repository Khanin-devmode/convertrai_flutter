import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:flutter/material.dart';
import '../features/unit_converter/presentation/helper_function.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RaiNganSqwaInput extends StatelessWidget {
  const RaiNganSqwaInput({
    super.key,
    required this.appLocal,
    required this.raiInputCtrl,
    required this.nganInputCtrl,
    required this.sqWhaInputCtrl,
    this.onChanged,
  });

  final AppLocalizations appLocal;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
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
              CustomInputField(
                label: appLocal.rai,
                inputTextController: raiInputCtrl,
                onChanged: (newValue) {
                  double rai = stringToDouble(newValue);
                  double ngan = stringToDouble(nganInputCtrl.text);
                  double sqWha = stringToDouble(sqWhaInputCtrl.text);
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
              CustomInputField(
                label: appLocal.ngan,
                inputTextController: nganInputCtrl,
                onChanged: (newValue) {
                  double rai = stringToDouble(raiInputCtrl.text);
                  double ngan = stringToDouble(newValue);
                  double sqWha = stringToDouble(sqWhaInputCtrl.text);
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
              InputLabel(label: appLocal.sqWha),
              CustomInputField(
                label: appLocal.sqWha,
                inputTextController: sqWhaInputCtrl,
                onChanged: (newValue) {
                  double rai = stringToDouble(raiInputCtrl.text);
                  double ngan = stringToDouble(nganInputCtrl.text);
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
