
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_clean_architecture/core/errors/failure.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/entity/user.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/usecases/get_user.dart';

part 'authentication_state.dart';

class AuthenticationCubit
    extends Cubit<AuthenticationState> {
  final CreateUserUseCase _createUserUseCase;
  final GetUsersUseCase _getUserUseCase;
  AuthenticationCubit(this._createUserUseCase, this._getUserUseCase)
      : super(const AuthenticationInitial());
  Future<void> createUserHandler(
      {required String createdAt, required String name, required String avatar}) async {
    emit(const CreatingUser());
    final result = await _createUserUseCase(CreateUserParams(
        createdAt: createdAt, name: name, avatar: avatar));
    result.fold(
      (failure) => emit(AuthError(failure.errorMessage)),
      (r) => emit(const UserCreated()),
    );
  }

  Future<void> getUsersHandler() async {
    emit(const GettingUsers());
    final result = await _getUserUseCase();
    result.fold(
        (failure) => emit(AuthError(failure.errorMessage)),
        (users) => emit(
              UserLoaded(users),
            ));
  }
}
