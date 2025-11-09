import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _userKey = 'user_data';
  static const String _usersKey = 'registered_users';

  // Get current user from storage
  Future<UserModel?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(_userKey);
      if (userData != null) {
        return UserModel.fromJson(jsonDecode(userData));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Register a new user
  Future<bool> register(String email, String password, String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Get existing users
      final usersJson = prefs.getString(_usersKey) ?? '[]';
      final List<dynamic> users = jsonDecode(usersJson);

      // Check if user already exists
      final existingUser = users.any((user) => user['email'] == email);
      if (existingUser) {
        return false;
      }

      // Create new user
      final newUser = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'email': email,
        'password': password,
        'name': name,
      };

      // Add to users list
      users.add(newUser);
      await prefs.setString(_usersKey, jsonEncode(users));

      return true;
    } catch (e) {
      return false;
    }
  }

  // Login user
  Future<UserModel?> login(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Get existing users
      final usersJson = prefs.getString(_usersKey) ?? '[]';
      final List<dynamic> users = jsonDecode(usersJson);

      // Find user with matching credentials
      final userData = users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => null,
      );

      if (userData != null) {
        final user = UserModel(
          id: userData['id'],
          email: userData['email'],
          name: userData['name'],
        );

        // Save current user
        await prefs.setString(_userKey, jsonEncode(user.toJson()));
        return user;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }
}
