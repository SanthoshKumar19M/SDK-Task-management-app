class AuthService {
  static const String staticEmail = "san@gm.com";
  static const String staticPassword = "12345678";

  static bool login(String email, String password) {
    return email == staticEmail && password == staticPassword;
  }
}
