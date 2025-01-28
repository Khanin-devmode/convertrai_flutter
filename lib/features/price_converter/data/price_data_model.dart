import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';

class PriceData {
  PriceData({
    required this.inputPrice,
    required this.inputArea,
    required this.inputAreaUnit,
    required this.outputArea,
    required this.outputAreaUnit,
  });

  double inputPrice;
  double inputArea;
  ConvertingUnit inputAreaUnit;

  double outputArea;
  ConvertingUnit outputAreaUnit;

  double getOutputPrice() {
    double sqm;
    double pricePerSqm;
    double outputPrice;

    switch (inputAreaUnit) {
      case ConvertingUnit.rai:
        {
          sqm = inputArea * 1600;
        }
        break;
      case ConvertingUnit.ngan:
        {
          sqm = inputArea * 400;
        }
        break;
      case ConvertingUnit.sqWa:
        {
          sqm = inputArea * 4;
        }
        break;
      case ConvertingUnit.sqm:
        {
          sqm = inputArea;
        }
        break;
      case ConvertingUnit.raiNganSqWha:
        {
          sqm = inputArea;
        }
        break;
      case ConvertingUnit.acre:
        {
          sqm = inputArea * 4046.86;
        }
        break;
    }

    pricePerSqm = inputPrice / sqm;

    switch (outputAreaUnit) {
      case ConvertingUnit.rai:
        outputPrice = outputArea * (pricePerSqm / 0.000625);
        break;
      case ConvertingUnit.ngan:
        outputPrice = outputArea * (pricePerSqm / 0.0025);
        break;
      case ConvertingUnit.sqWa:
        outputPrice = outputArea * (pricePerSqm / 0.25);
        break;
      case ConvertingUnit.raiNganSqWha:
      case ConvertingUnit.sqm:
        outputPrice = outputArea * pricePerSqm;
        break;
      case ConvertingUnit.acre:
        outputPrice = outputArea * 4046.86 * pricePerSqm;
        break;
    }

    return outputPrice;
  }
}
