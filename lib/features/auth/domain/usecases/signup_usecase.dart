import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignupUseCase {
  final AuthRepository _repository;

  SignupUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _repository.signup(
      fullName: fullName,
      email: email,
      password: password,
    );
  }
}
