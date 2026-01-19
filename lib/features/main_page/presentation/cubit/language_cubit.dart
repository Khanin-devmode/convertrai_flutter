import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super('th');

  void changeLanguage(String languageCode) {
    emit(languageCode);
  }
}
