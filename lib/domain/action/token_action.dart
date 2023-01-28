abstract class TokenAction {
  Future<void> getToken(String tokenCode);
  Future<bool> refreshToken();
}
