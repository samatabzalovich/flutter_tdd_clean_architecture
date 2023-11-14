import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/core/errors/failure.dart';
import 'package:flutter_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/entity/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  ResultFuture<List<User>> getUsers();
}
