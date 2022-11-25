import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_bloc/Models/user_model.dart';
import 'package:login_bloc/Repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_user_event.dart';
part 'auth_user_state.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  AuthUserBloc() : super(AuthUserLogout()) {
    final authUserRepository = AuthUserRepository();

    // SignIn
    on<SignInEvent>((event, emit) async {
      try {
        emit(AuthUserSignInLoading());
        final login = await authUserRepository.loginUser(event.email, event.password);
        if (login['success'] == true) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("accessToken", login['access_token']);
          prefs.setString("refreshToken", login['refresh_token']);
          prefs.setString("email", event.email);
          prefs.setString("password", event.password);
          emit(AuthUserLogin(login["user"]));
        } else {
          emit(AuthUserError(login['message']));
        }
      } catch (e) {
        emit(AuthUserError("Error SOmethings"));
      }
    });

    on<SignOutEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("accessToken");
      prefs.remove("refreshToken");
      prefs.remove("email");
      prefs.remove("password");
      emit(AuthUserLogout());
    });

    // Check User is Login Event
    on<CheckSignInStatusEvent>((event, emit) async {
      emit(AuthUserLoading());
      // get data from prefs
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString("accessToken");
      String? refreshToken = prefs.getString("refreshToken");
      String? email = prefs.getString("email");
      String? password = prefs.getString("password");

      // check if data exists
      if (accessToken != null && refreshToken != null) {
        // Check if token is still valid
        final checkAccessToken = await authUserRepository.checkToken(accessToken);
        if (checkAccessToken['success'] == true) {
          final login = await authUserRepository.loginUser(email!, password!);
          emit(AuthUserLogin(login['user']));
        } else {
          // Try to refresh Token
          final tryRefreshToken = await authUserRepository.refreshAccessToken(refreshToken);
          
          // check if refreshToken success
          if (tryRefreshToken['success'] == true ){
            prefs.remove("accessToken");
            prefs.remove("refreshToken");
            prefs.setString("accessToken", tryRefreshToken['access_token']);
            prefs.setString("refreshToken", tryRefreshToken['refresh_token']);
            final login = await authUserRepository.loginUser(email!, password!);
            emit(AuthUserLogin(login['user']));
          } else {
            emit(AuthUserLogout());
          }
        }
      } else {
        emit(AuthUserLogout());
      }
    });


  }
}
