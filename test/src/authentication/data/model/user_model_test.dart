import 'dart:convert';

import 'package:flutter_tdd_clean_architecture/core/utils/typedef.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/data/models/user_model.dart';
import 'package:flutter_tdd_clean_architecture/src/authentication/domain/entity/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test("should be subclass of [User] entity", () {
    //Act

    // Assert
    expect(tModel, isA<User>());
  });
  final tJson = fixture("test/fixtures/user.json");
  final tMap = jsonDecode(tJson) as DataMap;
  group("fromMap", () {
    test("should return a [UserModel] with the right data", () {
      // act
      final result = UserModel.fromMap(tMap);
      //Assert
      expect(result, equals(tModel));
    });
  });
  group("fromJson", () {
    test("should return a [UserModel] with the right data", () {
      // act
      final result = UserModel.fromJson(tJson);
      //Assert
      expect(result, equals(tModel));
    });
  });
  group("toMap", () {
    test("should return a [Map] with the right data", () {
      // act
      final result = tModel.toMap();
      //Assert
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    test("should return a [Map] with the right data", () {
      // act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id":"1",
        "createdAt":"_empty.createdAt",
        "name":"_empty.name",
        "avatar":"_empty.avatar"
      }
      );
      //Assert
      expect(result, equals(tJson));
    });
  });

  group("copyWith", () {
    test("should return a [UserModel] with the right data", () {
      // act
      final result = tModel.copyWith(name: "Paul");
      //Assert
      expect(result.name, equals("Paul"));
    });
  });

  
}
