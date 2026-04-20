import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/local_storage.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalStorage _localStorage;

  AuthBloc(this._localStorage) : super(const AuthState()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthStatusChanged>(_onAuthStatusChanged);
  }

  void _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) {
    final isLoggedIn = _localStorage.isLoggedIn();
    if (isLoggedIn) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _localStorage.clearToken();
    await _localStorage.setIsLoggedIn(false);
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  void _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) {
    if (event.isLoggedIn) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    }
  }
}
