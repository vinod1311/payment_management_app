import 'package:payment_management_app/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

///------------------------ Shared Preferences Database common methods
class SharedPreferencesHelper with Preferences{

  static late final SharedPreferences instance;

  ///--------- pref initialize
  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  ///-------- set theme
  static Future<void> setThemeMode(bool isDarkMode) async {
    instance.setBool(Preferences.THEME_MODE_KEY, isDarkMode);
  }

  ///---------- get theme
  static Future<bool> getThemeMode() async {
    return instance.getBool(Preferences.THEME_MODE_KEY) ?? false;
  }

}
