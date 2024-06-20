import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static Future<void> saveUser(String email, String password, String name) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> users = prefs.getStringList('users') ?? [];

    // Create a user map
    final userMap = {
      'email': email,
      'password': password,
      'name': name
    };

    // Convert the user map to a JSON string and add to the list
    users.add(userMap.toString());

    // Save the updated user list
    await prefs.setStringList('users', users);
  }

  static Future<List<Map<String, String>>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> users = prefs.getStringList('users') ?? [];
    return users.map((userString) {
      final Map<String, String> userMap = Map<String, String>.fromEntries(
        userString.substring(1, userString.length - 1).split(', ').map(
          (String pair) {
            final List<String> kv = pair.split(': ');
            return MapEntry(kv[0], kv[1]);
          },
        ),
      );
      return userMap;
    }).toList();
  }

  static Future<bool> authenticateUser(String email, String password) async {
    List<Map<String, String>> users = await getUsers();
    for (Map<String, String> user in users) {
      if (user['email'] == email && user['password'] == password) {
        return true;
      }
    }
    return false;
  }
}