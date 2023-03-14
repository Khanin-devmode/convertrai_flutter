import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveNotifier extends StateNotifier<List<String>> {
  SaveNotifier() : super([]);

  void saveResult(String result) {
    state = [...state, result];
  }

  void deleteResult(String deleteResult) {
    state = state.where((result) => result != deleteResult).toList();
  }
}

final saveNotifierProvider = StateNotifierProvider((ref) => SaveNotifier());
