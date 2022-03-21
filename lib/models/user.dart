import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "uid";
  static const FIRST_NAME = "first name";
  static const LAST_NAME = "last name";
  static const EMAIL = "email";

  late String _firstName;
  late String _lastName;
  late String _email;
  late String _id;


  //  getters
  String get first_name => _firstName;

  String get last_name => _lastName;

  String get email => _email;

  String get id => _id;

  //  public variable
  late int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _firstName = snapshot[FIRST_NAME];
    _lastName = snapshot[LAST_NAME];
    _email = snapshot[EMAIL];
    _id = snapshot[ID];
  }
}
