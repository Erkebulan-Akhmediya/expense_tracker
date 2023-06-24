import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  UserController();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('Users').doc(user.id).set(user.toMap());
  }

  Stream<UserModel> getUsername(String? uid) {
    DocumentReference docRef = _db.collection('Users').doc(uid);
    Stream<UserModel> docSnap = docRef.snapshots().map(
      (snapshot) {
        return UserModel(
          id: snapshot['id'],
          username: snapshot['username'],
          email: snapshot['email'],
          password: snapshot['password'],
        );
      },
    );

    return docSnap;
  }
}