import '../../data/models/user.dart';
import '../observers/auth_observer.dart';

abstract class AuthObservable {
  List<AuthObserver> observers = [];
  User? user;

  void notify(User? user) {
    this.user = user;
    for(AuthObserver observer in observers) {
      observer.notifyUser(user);
    }
  }

  void addObserver(AuthObserver observer) {
    observers.add(observer);
  }

  void removeObserver(AuthObserver observer) {
    observers.remove(observer);
  }

}