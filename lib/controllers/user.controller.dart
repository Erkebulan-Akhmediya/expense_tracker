import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/user.model.dart';

class UserController {
  UserController();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db.collection('Users').add(user.toMap());
  }
}