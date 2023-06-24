class UserModel {
  final String id;
  final String username;
  final String email;
  final String password;
  final List<String> expenses = [];

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
    'username': username,
    'email': email,
    'password': password,
    'expenses': [],
  };

  static UserModel fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'],
    username: map['username'],
    email: map['email'],
    password: map['password'],
  );
}