import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState with ChangeNotifier {
// This private instance variable _user holds the currently logged-in user.
//It is of type User?, which is provided by the firebase_auth package.
  User? _user;

// This is a getter method that provides read-only access to the _user variable.
//It allows other parts of the application to access the currently logged-in user.
  User? get user => _user;

// This method is used to update the _user variable with a new user.
//It takes a User? parameter newUser which represents the updated user information.
//It then assigns the newUser to _user and calls notifyListeners().
//This notifies all the listeners (widgets) that are dependent on UserState that a change has occurred, so they can update accordingly.
  void updateUser(User? newUser) {
    _user = newUser;
    print(_user);
    notifyListeners();
  }
}
