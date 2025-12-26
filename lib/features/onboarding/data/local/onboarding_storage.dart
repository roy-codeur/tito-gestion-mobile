import 'package:shared_preferences/shared_preferences.dart';

class OnboardingStorage {
  static const key = 'SEEN_ONBOARDING';

 Future<bool> isSeen () async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
 }

 Future<void> setSeen () async {
  final prefs = await SharedPreferences.getInstance();
   await prefs.setBool(key, true);

 }

}