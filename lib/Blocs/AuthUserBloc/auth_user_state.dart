part of 'auth_user_bloc.dart';

abstract class AuthUserState extends Equatable {
  const AuthUserState();
  
  @override
  List<Object> get props => [];
}

class AuthUserLoading extends AuthUserState {}

class AuthUserSignInLoading extends AuthUserState {}

class AuthUserLogin extends AuthUserState {
  final UserModel user;

  const AuthUserLogin(this.user);
  @override
  List<Object> get props => [user];
}

class AuthUserLogout extends AuthUserState {}

class AuthUserError extends AuthUserState {
  final String message;

  const AuthUserError(this.message);
  @override
  List<Object> get props => [message];
}
