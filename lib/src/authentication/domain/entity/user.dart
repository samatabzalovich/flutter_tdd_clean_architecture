import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String createdAt;
  final String name;
  final String avatar;
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });
  const User.empty()
      : this(
            avatar: "_empty.avatar",
            createdAt: "_empty.createdAt",
            name: "_empty.name",
            id: "1");
  @override
  List<Object> get props => [id, name, avatar, createdAt];

}
