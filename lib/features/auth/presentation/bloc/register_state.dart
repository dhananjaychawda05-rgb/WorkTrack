import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final RegisterStatus status;
  final String? errorMessage;
  final String? successMessage;

  const RegisterState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.status = RegisterStatus.initial,
    this.errorMessage,
    this.successMessage,
  });

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? password,
    RegisterStatus? status,
    String? errorMessage,
    String? successMessage,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        status,
        errorMessage,
        successMessage,
      ];
}
