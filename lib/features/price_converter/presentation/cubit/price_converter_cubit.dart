import 'package:convert_rai/features/price_converter/data/price_data_model.dart';
import 'package:convert_rai/features/price_converter/presentation/cubit/price_converter_state.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PriceConverterCubit extends Cubit<PriceConverterState> {
  PriceConverterCubit() : super(PriceConverterState.initial());

  void updatePriceData({
    double? inputPrice,
    double? inputSingleArea,
    double? inputRai,
    double? inputNgan,
    double? inputSqWa,
    ConvertingUnit? inputAreaUnit,
    double? outputSingleArea,
    double? outputRai,
    double? outputNgan,
    double? outputSqWa,
    ConvertingUnit? outputAreaUnit,
  }) {
    final newPriceData = PriceData(
      inputSingleArea: inputSingleArea ?? state.priceData.inputSingleArea,
      inputPrice: inputPrice ?? state.priceData.inputPrice,
      inputAreaUnit: inputAreaUnit ?? state.priceData.inputAreaUnit,
      inputRai: inputRai ?? state.priceData.inputRai,
      inputNgan: inputNgan ?? state.priceData.inputNgan,
      inputSqWa: inputSqWa ?? state.priceData.inputSqWa,
      outputArea: outputSingleArea ?? state.priceData.outputArea,
      outputAreaUnit: outputAreaUnit ?? state.priceData.outputAreaUnit,
      outputRai: outputRai ?? state.priceData.outputRai,
      outputNgan: outputNgan ?? state.priceData.outputNgan,
      outputSqWa: outputSqWa ?? state.priceData.outputSqWa,
    );

    emit(state.copyWith(priceData: newPriceData));
  }

  @override
  Future<void> close() {
    state.singleInputCtrl.dispose();
    state.raiInputCtrl.dispose();
    state.nganInputCtrl.dispose();
    state.sqWhaInputCtrl.dispose();
    state.priceInputCtrl.dispose();
    state.singleOutputCtrl.dispose();
    state.raiOutputCtrl.dispose();
    state.nganOutputCtrl.dispose();
    state.sqWhaOutputCtrl.dispose();
    return super.close();
  }
}
