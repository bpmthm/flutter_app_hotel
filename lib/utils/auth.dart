class Auth {
  static String? token;
  static bool isLoggedIn = false;

  static void setToken(String newToken) {
    token = newToken;
    isLoggedIn = true;
  }

  static void logout() {
    token = null;
    isLoggedIn = false;
  }
}
