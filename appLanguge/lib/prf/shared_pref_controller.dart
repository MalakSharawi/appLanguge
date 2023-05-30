import 'package:applanguge/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum PrefKeys { loggedIn, email,id,name }

class SharedPrefController {
  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  SharedPrefController._();

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferansces() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required User user}) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    await _sharedPreferences.setInt(PrefKeys.id.name, user.id);
    await _sharedPreferences.setString(PrefKeys.name.name,user.name);
    await _sharedPreferences.setString(PrefKeys.email.name,user.email);

  }

  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKeys.loggedIn.name) ?? false;

  Future<bool> removeValueFor({required String key}) async {
    if (_sharedPreferences.containsKey(key)) {
      await _sharedPreferences.remove(key);
    }
    return false;
  }

  T? getValueFor<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }
}
