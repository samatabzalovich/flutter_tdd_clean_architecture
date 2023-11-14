import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/entity/user.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/usecases/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late GetUserUseCase usecase;
  late AuthenticationRepository repository;
  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUserUseCase(repository);
  });
  const tResponse = [const User.empty()];
  test("should call [AuthRepo.getUsers] and return [List<Users>]", () async {
    // Arrange
    when(() => repository.getUsers()).thenAnswer((_) async => Right(tResponse));
    //ACT
    final result = await usecase();
    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
  });
}
