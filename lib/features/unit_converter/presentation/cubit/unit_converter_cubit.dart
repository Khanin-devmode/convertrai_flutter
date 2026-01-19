import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/cubit/unit_converter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnitConverterCubit extends Cubit<UnitConverterState> {
  UnitConverterCubit() : super(UnitConverterState.initial());

  void convertUnit(double newValue) {
    Calculation newCal = Calculation();

    newCal.selectedUnit = state.calculation.selectedUnit;

    switch (newCal.selectedUnit) {
      case ConvertingUnit.rai:
        {
          newCal.sqm = newValue * 1600;
        }
        break;
      case ConvertingUnit.ngan:
        {
          newCal.sqm = newValue * 400;
        }
        break;
      case ConvertingUnit.sqWa:
        {
          newCal.sqm = newValue * 4;
        }
        break;
      case ConvertingUnit.sqm:
        {
          newCal.sqm = newValue;
        }
        break;
      case ConvertingUnit.raiNganSqWha:
        {
          newCal.sqm = newValue;
        }
        break;
      case ConvertingUnit.acre:
        {
          newCal.sqm = newValue * 4046.86;
        }
        break;
      case ConvertingUnit.hectare:
        {
          newCal.sqm = newValue * 10000;
        }
        break;
      case ConvertingUnit.sqKm:
        {
          newCal.sqm = newValue * 1000000;
        }
        break;
      case ConvertingUnit.sqFt:
        {
          newCal.sqm = newValue * 0.09290304;
        }
        break;
    }

    newCal.fullRai = newCal.sqm / 1600;
    newCal.fullNgan = newCal.sqm / 400;
    newCal.fullSqWha = newCal.sqm / 4;

    newCal.rai = (newCal.fullSqWha / 400).floorToDouble();
    newCal.sqWhaRemainder = newCal.fullSqWha.remainder(400);
    newCal.ngan = (newCal.sqWhaRemainder / 100).floorToDouble();
    newCal.sqWha = newCal.sqWhaRemainder.remainder(100);
    newCal.acre = newCal.sqm / 4046.86;
    newCal.hectare = newCal.sqm / 10000;
    newCal.sqKm = newCal.sqm / 1000000;
    newCal.sqFt = newCal.sqm / 0.09290304;

    emit(state.copyWith(calculation: newCal));
  }

  void convertCombinedUnit(double rai, double ngan, double sqWha) {
    double sqm = (rai * 1600) + (ngan * 400) + (sqWha * 4);
    convertUnit(sqm);
  }

  void selectUnit(ConvertingUnit newUnit) {
    Calculation newState = Calculation();

    newState.selectedUnit = newUnit;

    newState.sqm = state.calculation.sqm;
    newState.rai = state.calculation.rai;
    newState.ngan = state.calculation.ngan;
    newState.sqWha = state.calculation.sqWha;
    newState.fullRai = state.calculation.fullRai;
    newState.fullNgan = state.calculation.fullNgan;
    newState.fullSqWha = state.calculation.fullSqWha;
    newState.sqWhaRemainder = state.calculation.sqWhaRemainder;
    newState.acre = state.calculation.acre;
    newState.hectare = state.calculation.hectare;
    newState.sqKm = state.calculation.sqKm;
    newState.sqFt = state.calculation.sqFt;

    emit(state.copyWith(calculation: newState));
  }

  void resetState() {
    emit(state.copyWith(calculation: Calculation()));
  }

  @override
  Future<void> close() {
    state.singleInputCtrl.dispose();
    state.raiInputCtrl.dispose();
    state.nganInputCtrl.dispose();
    state.sqWhaInputCtrl.dispose();
    return super.close();
  }
}
