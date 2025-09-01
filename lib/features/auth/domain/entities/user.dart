import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    profileImage,
    createdAt,
    updatedAt,
  ];

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
