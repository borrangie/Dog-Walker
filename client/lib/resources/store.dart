import 'package:dogwalker2/models/users/user.dart';

class Store {
  static Store _instance = Store._();
  Map<String, dynamic> _elements = {};

  Store._();

  static Store get instance => _instance;

  User get user => this._elements["user"];

  set user(User user) => this._elements["user"] = user;
}
