// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserEntity {
  final String userId;
  final String name;
  final String email;
  final String avatarurl;
  final DateTime updatedAt;
  UserEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.avatarurl,
    required this.updatedAt,
  });

  UserEntity copyWith({
    String? userId,
    String? name,
    String? email,
    String? avatarurl,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarurl: avatarurl ?? this.avatarurl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': userId,
      'name': name,
      'email': email,
      'avatar_url': avatarurl,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      userId: map['user_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatarurl: map['avatar_url'] as String,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEntity(userId: $userId, name: $name, email: $email, avatarurl: $avatarurl, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserEntity other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.avatarurl == avatarurl &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        avatarurl.hashCode ^
        updatedAt.hashCode;
  }
}
