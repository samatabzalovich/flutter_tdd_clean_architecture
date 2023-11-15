import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_clean_architecture/core/errors/failure.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/usecases/get_user.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsersUseCase {}

class MockCreateUser extends Mock implements CreateUserUseCase {}

void main() {
  late GetUsersUseCase getUsers;
  late CreateUserUseCase createUser;
  late AuthenticationCubit cubit;
  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: "message", statusCode: 400);
  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser, getUsers);
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());
  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });
  group(
    "createUser",
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
          'emits [CreatingUser, UserCreated]',
          build: () {
            when(
              () => createUser(tCreateUserParams),
            ).thenAnswer(
              (_) async => const Right(null),
            );
            return cubit;
          },
          act: (cubit) => cubit.createUserHandler(
              createdAt: tCreateUserParams.createdAt,
              name: tCreateUserParams.name,
              avatar: tCreateUserParams.avatar),
          expect: () => [
                const CreatingUser(),
                const UserCreated(),
              ],
          verify: (_) {
            verify(
              () => createUser(tCreateUserParams),
            ).called(1);
            verifyNoMoreInteractions(createUser);
          });

          blocTest<AuthenticationCubit, AuthenticationState>(
          'emits [CreatingUser, AuthenticationError]',
          build: () {
            when(
              () => createUser(tCreateUserParams),
            ).thenAnswer(
              (_) async => const Left(tApiFailure),
            );
            return cubit;
          },
          act: (cubit) => cubit.createUserHandler(
              createdAt: tCreateUserParams.createdAt,
              name: tCreateUserParams.name,
              avatar: tCreateUserParams.avatar),
          expect: () => [
                const CreatingUser(),
                AuthError(tApiFailure.errorMessage),
              ],
          verify: (_) {
            verify(
              () => createUser(tCreateUserParams),
            ).called(1);
            verifyNoMoreInteractions(createUser);
          });
    },
  );
  group(
    "getUser",
    () {
      blocTest<AuthenticationCubit, AuthenticationState>(
          'emits [GettingUser, UserLoaded]',
          build: () {
            when(
              () => getUsers(),
            ).thenAnswer(
              (_) async => const Right([]),
            );
            return cubit;
          },
          act: (cubit) => cubit.getUsersHandler(),
          expect: () => [
                const GettingUsers(),
                const UserLoaded([]),
              ],
          verify: (_) {
            verify(
              () => getUsers(),
            ).called(1);
            verifyNoMoreInteractions(getUsers);
          });

          blocTest<AuthenticationCubit, AuthenticationState>(
          'emits [GettingUser, AuthError]',
          build: () {
            when(
              () => getUsers(),
            ).thenAnswer(
              (_) async => const Left(tApiFailure),
            );
            return cubit;
          },
          act: (cubit) => cubit.getUsersHandler(),
          expect: () => [
                const GettingUsers(),
                AuthError(tApiFailure.errorMessage),
              ],
          verify: (_) {
            verify(
              () => getUsers(),
            ).called(1);
            verifyNoMoreInteractions(createUser);
          });
    },
  );
}
