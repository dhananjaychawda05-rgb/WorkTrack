import 'package:injectable/injectable.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });

  Future<String> signup({
    required String fullName,
    required String email,
    required String password,
  });
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _dioClient.post(
      ApiEndpoints.authLogin,
      data: {
        'email': email,
        'password': password,
      },
    );

    // Based on user's API response:
    // { "success": true, "data": { "user": { "id": "...", "email": "...", "email_verified": true }, "session": { "access_token": "...", ... } } }
    if (response['success'] == true) {
      return response['data'];
    } else {
      throw Exception(response['error'] ?? 'Login failed');
    }
  }

  @override
  Future<String> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final response = await _dioClient.post(
      ApiEndpoints.authSignup,
      data: {
        'full_name': fullName,
        'email': email,
        'password': password,
      },
    );

    // Based on user's API response:
    // { "success": true, "message": "Signup successful. Please verify your email.", "data": { "email": "...", "id": "..." } }
    if (response['success'] == true) {
      return response['message'] ?? 'Signup successful';
    } else {
      throw Exception(response['error'] ?? 'Signup failed');
    }
  }
}
