import '../Resources/auth_resource.dart';

class AuthUserRepository {
  final _resource = AuthUserResource();

  Future loginUser(String email, String password){
  return  _resource.loginUser(email, password);
  }

  Future checkToken(String accessToken){
    return _resource.checkToken(accessToken);
  }

  Future refreshAccessToken(String refreshToken){
    return _resource.refreshAccessToken(refreshToken);
  }
}