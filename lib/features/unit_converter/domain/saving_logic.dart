import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  void initHiveSavingBox() async {
    var box = await Hive.openBox('saveResultBox');

    await box.put('results', ['1', '2', '3']);
    var results = await box.get('results');

    print(results);
  }
}

final saveNotifierProvider =
    StateNotifierProvider<SaveNotifier, List<String>>((ref) => SaveNotifier());
