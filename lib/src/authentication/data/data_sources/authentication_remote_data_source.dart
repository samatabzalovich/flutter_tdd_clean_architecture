import 'dart:convert';

import 'package:flutter_tdd_clean_architecture/core/errors/exceptions.dart';
import 'package:flutter_tdd_clean_architecture/core/utils/constant.dart';
import 'package:flutter_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });
  Future<List<UserModel>> getUsers();
}

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;

  AuthRemoteDataSrcImpl(this._client);

  @override
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(
        Uri.https(
          kBaseUrl, kCreateUserEndpoint,
        ),
        body: jsonEncode(
          {
            "createdAt": createdAt,
            "name": name,
            "avatar": avatar,
          },
        ),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw (ApiException(
            message: response.body, statusCode: response.statusCode));
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw (ApiException(message: e.toString(), statusCode: 505));
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(Uri.https(kBaseUrl, kGetUserEndpoint));
      
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((e) => UserModel.fromMap(e))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw (ApiException(message: e.toString(), statusCode: 505));
    }
  }
}
