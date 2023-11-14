import 'dart:convert';

import 'package:flutter_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/entity/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.avatar,
      required super.id,
      required super.createdAt,
      required super.name});
  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as String,
      createdAt: map['createdAt'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
    );
  }
  String toJson() => json.encode(toMap());
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);
  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'name': name,
      'avatar': avatar,
    };
  }

  const UserModel.empty()
      : this(
            id: '1',
            createdAt: '_empty.createdAt',
            name: '_empty.name',
            avatar: '_empty.avatar');

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
