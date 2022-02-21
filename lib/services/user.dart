import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leafly/models/user.dart';

class UserServices {
  String collection = "users";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).doc(id).set(values);
  }

  void updateUserData(Map<String, dynamic> values) {
    _firestore.collection(collection).doc(values['id']).update(values);
  }

  void deleteUser(String userId) async {
    await users.doc(userId).delete();
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}
