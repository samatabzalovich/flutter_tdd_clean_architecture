// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_tdd_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/repository/authentication_repository.dart';

class CreateUserUseCase extends UseCaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;

  const CreateUserUseCase(
    this._repository,
  );

  @override
  ResultVoid call(CreateUserParams params) async {
    return _repository.createUser(
        createdAt: params.createdAt, name: params.name, avatar: params.avatar);
  }
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;
  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });
  const CreateUserParams.empty()
      : this(
            avatar: "empty_avatar",
            createdAt: "empty_createdAt",
            name: "empty_name");
  @override
  List<Object?> get props => [createdAt, name, avatar];
}
