import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'register_event.dart';
import 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SignupUseCase _signupUseCase;

  RegisterBloc(this._signupUseCase) : super(const RegisterState()) {
    on<RegisterFullNameChanged>(_onFullNameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  void _onFullNameChanged(
    RegisterFullNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(fullName: event.fullName, status: RegisterStatus.initial));
  }

  void _onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(email: event.email, status: RegisterStatus.initial));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(password: event.password, status: RegisterStatus.initial));
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.fullName.isEmpty || state.email.isEmpty || state.password.isEmpty) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'All fields are required',
        ),
      );
      return;
    }

    emit(state.copyWith(status: RegisterStatus.loading));

    final result = await _signupUseCase.call(
      fullName: state.fullName.trim(),
      email: state.email.trim(),
      password: state.password.trim(),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (message) => emit(
        state.copyWith(
          status: RegisterStatus.success,
          successMessage: message,
        ),
      ),
    );
  }
}
