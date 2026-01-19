import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';

class PriceData {
  PriceData({
    required this.inputPrice,
    required this.inputSingleArea,
    required this.inputAreaUnit,
    required this.outputArea,
    required this.outputAreaUnit,
    required this.inputRai,
    required this.inputNgan,
    required this.inputSqWa,
    required this.outputRai,
    required this.outputNgan,
    required this.outputSqWa,
  });

  double inputPrice;
  double inputSingleArea;
  double inputRai;
  double inputNgan;
  double inputSqWa;
  ConvertingUnit inputAreaUnit;

  double outputArea;
  double outputRai;
  double outputNgan;
  double outputSqWa;
  ConvertingUnit outputAreaUnit;

  double getOutputPrice() {
    double sqm;
    double pricePerSqm;
    double outputPrice;

    switch (inputAreaUnit) {
      case ConvertingUnit.rai:
        sqm = inputSingleArea * 1600;
        break;

      case ConvertingUnit.ngan:
        sqm = inputSingleArea * 400;
        break;

      case ConvertingUnit.sqWa:
        sqm = inputSingleArea * 4;
        break;

      case ConvertingUnit.raiNganSqWha:
        sqm = (inputRai * 1600) + (inputNgan * 400) + (inputSqWa * 4);
        break;

      case ConvertingUnit.sqm:
        sqm = inputSingleArea;
        break;

      case ConvertingUnit.acre:
        sqm = inputSingleArea * 4046.86;
        break;

      case ConvertingUnit.hectare:
        sqm = inputSingleArea * 10000;
        break;

      case ConvertingUnit.sqKm:
        sqm = inputSingleArea * 1000000;
        break;

      case ConvertingUnit.sqFt:
        sqm = inputSingleArea * 0.09290304;
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
        outputPrice =
            ((outputRai * 1600) + (outputNgan * 400) + (outputSqWa * 4)) *
                pricePerSqm;
        break;
      case ConvertingUnit.sqm:
        outputPrice = outputArea * pricePerSqm;
        break;
      case ConvertingUnit.acre:
        outputPrice = outputArea * 4046.86 * pricePerSqm;
        break;

      case ConvertingUnit.hectare:
        outputPrice = outputArea * 10000 * pricePerSqm;
        break;

      case ConvertingUnit.sqKm:
        outputPrice = outputArea * 1000000 * pricePerSqm;
        break;

      case ConvertingUnit.sqFt:
        outputPrice = outputArea * 0.09290304 * pricePerSqm;
        break;
    }

    return outputPrice;
  }
}
