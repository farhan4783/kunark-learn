import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final DateTime createdAt;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  // Create a copy with updated fields
  User copyWith({
    String? name,
    String? email,
    String? password,
    DateTime? createdAt,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
