import 'package:convert_rai/features/unit_converter/presentation/cubit/save_result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SaveResultCubit extends Cubit<SaveResultState> {
  SaveResultCubit() : super(SaveResultState.initial());

  late Box box;

  Future<void> initHiveSavingBox() async {
    box = await Hive.openBox('saveResultBox');
    final results = await box.get('results') ?? [];
    emit(state.copyWith(
      savedResults: List<String>.from(results),
      isInitialized: true,
    ));
  }

  Future<void> saveResult(String result) async {
    final updatedResults = [...state.savedResults, result];
    await box.put('results', updatedResults);
    emit(state.copyWith(savedResults: updatedResults));
  }

  Future<void> deleteResult(int index) async {
    final first = state.savedResults.sublist(0, index);
    final second = state.savedResults.sublist(index + 1, state.savedResults.length);
    final updatedResults = first + second;
    await box.put('results', updatedResults);
    emit(state.copyWith(savedResults: updatedResults));
  }
}
