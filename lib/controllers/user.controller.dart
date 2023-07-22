import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('Users').doc(user.id).set(user.toMap());
  }

  Stream<UserModel> getUser(String uid) {
    DocumentReference docRef = _db.collection('Users').doc(uid);
    Stream<UserModel> user = docRef.snapshots().map(
      (DocumentSnapshot snapshot) {
        return UserModel(
          id: uid.toString(),
          username: snapshot['username'],
          email: snapshot['email'],
          password: snapshot['password'],
          expenses: List<String>.from(snapshot['expenses']),
        );
      }
    );

    return user;
  }
}