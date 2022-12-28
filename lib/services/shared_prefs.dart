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

  Future<void> setDepositStatus(bool paid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('deposit_paid', paid);
  }

  Future<void> setWalletAmount(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('wallet_amount', amount);
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

  Future<bool?> getDepositStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('deposit_paid') ?? false;
  }

  Future<int?> getWalletAmount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('wallet_amount') ?? 0;
  }

  // contains //
  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
