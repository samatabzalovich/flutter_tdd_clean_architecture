import 'package:flutter_tdd_clean_architecture/src/authentication/data/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/data/repository/authentication_repository_impl.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/usecases/get_user.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
  //App logic
    ..registerFactory(() => AuthenticationCubit(sl(), sl()))
    //UseCases
    ..registerLazySingleton(() => GetUsersUseCase(sl()))
    ..registerLazySingleton(() => CreateUserUseCase(sl()))
    //Repository
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(sl()))
        //Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))
        //External Dependencies
    ..registerLazySingleton(() => http.Client());
}
