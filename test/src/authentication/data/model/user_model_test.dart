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
      expect(result, equals(tModel));
    });
  });
}
