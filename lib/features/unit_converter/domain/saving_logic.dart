import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SaveNotifier extends StateNotifier<List<String>> {
  SaveNotifier() : super([]);

  late Box box;

  void initHiveSavingBox() async {
    box = await Hive.openBox('saveResultBox');
    state = await box.get('results') ?? [];
  }

  void saveResult(String result) async {
    state = [...state, result];
    await box.put('results', state);
  }

  // void deleteAllResult(String deleteResult) {
  //   state = state.where((result) => result != deleteResult).toList();
  // }

  void deleteResult(int i) async {
    var fist = state.sublist(0, i);
    var second = state.sublist(i + 1, state.length);
    state = fist + second;
    await box.put('results', state);
  }
}

final saveNotifierProvider =
    StateNotifierProvider<SaveNotifier, List<String>>((ref) => SaveNotifier());
