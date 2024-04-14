part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class AuthSignUpEvent extends AuthEvent{
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  AuthSignUpEvent({required this.firstName, required this.lastName, required this.email, required this.password});
}

class AuthSignInEvent extends AuthEvent{
  final String email;
  final String password;
  AuthSignInEvent({required this.email, required this.password});
}
