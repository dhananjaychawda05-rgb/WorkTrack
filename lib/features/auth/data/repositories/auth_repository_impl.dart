import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/local_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final LocalStorage _localStorage;

  AuthRepositoryImpl(this._remoteDataSource, this._localStorage);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      final user = UserModel.fromJson(data['user']);
      final session = data['session'];
      final token = session['access_token'];

      if (token != null) {
        await _localStorage.setToken(token);
        await _localStorage.setIsLoggedIn(true);
      }

      return Right(user);
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(e.message));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final message = await _remoteDataSource.signup(
        fullName: fullName,
        email: email,
        password: password,
      );
      return Right(message);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
