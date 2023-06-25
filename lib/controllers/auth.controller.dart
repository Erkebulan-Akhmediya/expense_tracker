import 'package:expense_tracker/controllers/user.controller.dart';
import 'package:expense_tracker/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final UserController _userController = UserController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _userController.createUser(
      UserModel(
        id: currentUser!.uid,
        username: username,
        email: email,
        password: password,
        expenses: [],
      ),
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}