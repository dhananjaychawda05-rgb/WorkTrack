import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../utils/local_storage.dart';

@injectable
class ThemeCubit extends Cubit<bool> {
  final LocalStorage _localStorage;

  // state = true for Dark Mode, false for Light Mode
  ThemeCubit(this._localStorage) : super(_localStorage.isDarkMode());

  void toggleTheme() {
    final newTheme = !state;
    _localStorage.setIsDarkMode(newTheme);
    emit(newTheme);
  }

  void setTheme(bool isDark) {
    _localStorage.setIsDarkMode(isDark);
    emit(isDark);
  }
}
