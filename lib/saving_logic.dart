import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveNotifier extends StateNotifier<List<String>> {
  SaveNotifier() : super([]);

  void saveResult(String result) {
    state = [...state, result];
  }

  // void deleteAllResult(String deleteResult) {
  //   state = state.where((result) => result != deleteResult).toList();
  // }

  void deleteResult(int i) {
    var fist = state.sublist(0, i);
    var second = state.sublist(i + 1, state.length);
    state = fist + second;
  }
}

final saveNotifierProvider =
    StateNotifierProvider<SaveNotifier, List<String>>((ref) => SaveNotifier());
