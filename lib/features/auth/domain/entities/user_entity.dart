import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final bool? emailVerified;

  const UserEntity({
    required this.id,
    required this.email,
    this.emailVerified,
  });

  @override
  List<Object?> get props => [id, email, emailVerified];
}
