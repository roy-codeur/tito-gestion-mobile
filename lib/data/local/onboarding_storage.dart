import 'package:get_storage/get_storage.dart';

class OnboardingStorage {
  final GetStorage box;

  static const key = 'SEEN_ONBOARDING';

  OnboardingStorage(this.box);

  bool isSeen() {
    return box.read(key) ?? false;
  }

  void setSeen() {
    box.write(key, true);
  }
}