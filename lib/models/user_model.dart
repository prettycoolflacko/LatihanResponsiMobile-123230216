class UserModel {
  final int? id;
  final String name;
  final String username;
  final String password;

  const UserModel({
    this.id,
    required this.name,
    required this.username,
    required this.password,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, Object?> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String? ?? '',
      username: map['username'] as String? ?? '',
      password: map['password'] as String? ?? '',
    );
  }
}
