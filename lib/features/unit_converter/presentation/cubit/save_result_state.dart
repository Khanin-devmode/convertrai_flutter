import 'package:equatable/equatable.dart';

class SaveResultState extends Equatable {
  final List<String> savedResults;
  final bool isInitialized;

  const SaveResultState({
    required this.savedResults,
    this.isInitialized = false,
  });

  factory SaveResultState.initial() {
    return const SaveResultState(
      savedResults: [],
      isInitialized: false,
    );
  }

  SaveResultState copyWith({
    List<String>? savedResults,
    bool? isInitialized,
  }) {
    return SaveResultState(
      savedResults: savedResults ?? this.savedResults,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object?> get props => [savedResults, isInitialized];
}
