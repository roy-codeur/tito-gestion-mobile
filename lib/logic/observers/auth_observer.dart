import '../../data/models/user.dart';

abstract class AuthObserver {

  void notifyUser(User? user);
}