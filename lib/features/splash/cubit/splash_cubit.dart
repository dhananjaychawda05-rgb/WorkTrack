import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/local_storage.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final LocalStorage _localStorage;

  SplashCubit(this._localStorage) : super(const SplashInitial());

  Future<void> init() async {
    emit(const SplashLoading());

    // Minimum splash display duration for branding visibility
    await Future.delayed(const Duration(milliseconds: 2500));

    final bool hasSeenOnboarding = _localStorage.hasSeenOnboarding();
    final bool isLoggedIn = _localStorage.isLoggedIn();

    if (!hasSeenOnboarding) {
      emit(const SplashNavigateToOnboarding());
    } else if (!isLoggedIn) {
      emit(const SplashNavigateToLogin());
    } else {
      emit(const SplashNavigateToHome());
    }
  }
}