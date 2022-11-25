part of 'auth_user_bloc.dart';

abstract class AuthUserEvent extends Equatable {
  const AuthUserEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthUserEvent {
  final String email;
  final String password;

  const SignInEvent(this.email, this.password);
  @override
  List<Object> get props => [email,password];
}

class SignOutEvent extends AuthUserEvent {}

class CheckSignInStatusEvent extends AuthUserEvent {}
