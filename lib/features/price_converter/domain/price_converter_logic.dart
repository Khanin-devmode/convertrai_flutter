import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceCalNotifier extends StateNotifier<double> {
  PriceCalNotifier() : super(0);

  void convertPrice(double inputPrice, double unitValue,
      ConvertingUnit inputUnit, ConvertingUnit outputUnit) {
    double sqm;
    double pricerPerSqm;

    switch (inputUnit) {
      case ConvertingUnit.rai:
        {
          sqm = unitValue * 1600;
        }
        break;
      case ConvertingUnit.ngan:
        {
          sqm = unitValue * 400;
        }
        break;
      case ConvertingUnit.sqWha:
        {
          sqm = unitValue * 4;
        }
        break;
      case ConvertingUnit.sqm:
        {
          sqm = unitValue;
        }
        break;
      case ConvertingUnit.raiNganSqWha:
        {
          sqm = unitValue;
        }
        break;
    }

    // var fullRai = sqm / 1600;
    // var fullNgan = sqm / 400;
    // var fullSqWha = sqm / 4;

    // var rai = (fullSqWha / 400).floorToDouble();
    // var sqWhaRemainder = fullSqWha.remainder(400);
    // var ngan = (sqWhaRemainder / 100).floorToDouble();
    // var sqWha = sqWhaRemainder.remainder(100);

    pricerPerSqm = inputPrice / sqm;

    switch (outputUnit) {
      case ConvertingUnit.rai:
        {
          state = pricerPerSqm * 0.000625;
        }
        break;
      case ConvertingUnit.ngan:
        {
          state = pricerPerSqm * 0.0025;
        }
        break;
      case ConvertingUnit.sqWha:
        {
          state = pricerPerSqm * 0.25;
        }
        break;
      case ConvertingUnit.sqm:
        {
          state = pricerPerSqm;
        }
        break;
      case ConvertingUnit.raiNganSqWha:
        {
          break;
        }
    }
  }

  void convertCombinedUnit(double rai, double ngan, double sqWha,
      double inputPrice, ConvertingUnit outputUnit) {
    double sqm = (rai * 1600) + (ngan * 400) + (sqWha * 4);

    convertPrice(inputPrice, sqm, ConvertingUnit.sqm, outputUnit);
  }
}

final calNotifierProvider =
    StateNotifierProvider<PriceCalNotifier, double>((ref) {
  return PriceCalNotifier();
});
