// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_tdd_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/entity/user.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/repository/authentication_repository.dart';

class GetUserUseCase extends UseCaseWithoutParams<List<User>> {
  final AuthenticationRepository _repository;
  GetUserUseCase(
    this._repository
  );
  @override
  ResultFuture<List<User>> call() {
    return _repository.getUsers();
  }
}
