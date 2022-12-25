import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefGetsNSets {
// setters //
  Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  Future<void> setPhoneNumber(String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('phone_number', phoneNumber);
  }

  Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  Future<void> setAvatarIndex(int avatarIndex) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('avatar_index', avatarIndex);
  }

  // getters //
  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? 'default@mail.com';
  }

  Future<String?> getPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone_number');
  }

  Future<String?> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? 'DefaultName';
  }

  Future<int?> getAvatarIndex() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('avatar_index') ?? 1;
  }

  // contains //
  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
