import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.userId,
    required super.name,
    required super.email,
    required super.avatarurl,
    required super.updatedAt,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatarurl: map['avatar_url'] as String,
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
