import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_tdd_clean_architecture/core/errors/failure.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/data/repository/authentication_repository_impl.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repoImpl;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthenticationRepositoryImpl(remoteDataSource);
  });
  const tException =
      ApiException(message: "unknown error occured", statusCode: 500);
  group("createUser", () {
    const createdAt = "whenever.date";
    const name = "whatever.name";
    const avatar = "whatever.avatar";
    test(
        "should call [RemoteDataSource.createUser] and complete successfully when the call is successfull",
        () async {
      //arrange
      when(
        () => remoteDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar")),
      ).thenAnswer((_) async => Future.value());

      //act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);

      //assert
      expect(result, equals(const Right(null)));
      //check that remotesource`s create user gets called
      //with the right data
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
        "should call [ApiFailure] when the call to the RemoteSource is unsuccessful",
        () async {
      //arrange
      when(
        () => remoteDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar")),
      ).thenThrow(tException);
      //act
      final result = await repoImpl.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      //assert
      expect(
        result,
        Left(
          ApiFailure(
              message: tException.message, statusCode: tException.statusCode),
        ),
      );
      verify(() => remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
  group("getUser", () {
    const createdAt = "whenever.date";
    const name = "whatever.name";
    const avatar = "whatever.avatar";
    test(
        "should call [RemoteDataSource.getUser] and return [List<User>]",
        () async {
      //arrange
      when(
        () => remoteDataSource.getUsers()
      ).thenAnswer((_) async => []);

      //act
      final result = await repoImpl.getUsers();

      //assert
      expect(result, isA<Right<dynamic, List<User>>>());
      //check that remotesource`s create user gets called
      //with the right data
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
        "should call [ApiFailure] when the call to the RemoteSource is unsuccessful",
        () async {
      //arrange
      when(
        () => remoteDataSource.getUsers(),
      ).thenThrow(tException);
      //act
      final result = await repoImpl.getUsers();
      //assert
      expect(
        result,
        Left(
          ApiFailure(
              message: tException.message, statusCode: tException.statusCode),
        ),
      );
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
