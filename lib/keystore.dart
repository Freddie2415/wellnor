// здесь хранится токен jwt
class JwtTokenStore {
  static String _jwtToken = '';

  bool get hasToken => _jwtToken.isNotEmpty;

  String setToken(String token) {
    _jwtToken = token;
  }

  void deleteToken() {
    _jwtToken = '';
  }

  String getToken() {
    return _jwtToken;
  }
}
