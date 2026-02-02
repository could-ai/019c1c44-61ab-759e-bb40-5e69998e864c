class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String _adminUsername = 'admin';
  String _adminPassword = 'admin123';

  bool login(String username, String password) {
    return username == _adminUsername && password == _adminPassword;
  }

  bool changePassword(String currentPassword, String newPassword) {
    if (currentPassword == _adminPassword) {
      _adminPassword = newPassword;
      return true;
    }
    return false;
  }
}
