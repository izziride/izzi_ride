// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserRepo on _UserRepo, Store {
  late final _$userInfoAtom =
      Atom(name: '_UserRepo.userInfo', context: context);

  @override
  UserData get userInfo {
    _$userInfoAtom.reportRead();
    return super.userInfo;
  }

  @override
  set userInfo(UserData value) {
    _$userInfoAtom.reportWrite(value, super.userInfo, () {
      super.userInfo = value;
    });
  }

  late final _$userCarAtom = Atom(name: '_UserRepo.userCar', context: context);

  @override
  ObservableList<UserCar> get userCar {
    _$userCarAtom.reportRead();
    return super.userCar;
  }

  @override
  set userCar(ObservableList<UserCar> value) {
    _$userCarAtom.reportWrite(value, super.userCar, () {
      super.userCar = value;
    });
  }

  late final _$getUserInfoAsyncAction =
      AsyncAction('_UserRepo.getUserInfo', context: context);

  @override
  Future<void> getUserInfo() {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo());
  }

  late final _$getUserCarAsyncAction =
      AsyncAction('_UserRepo.getUserCar', context: context);

  @override
  Future<void> getUserCar() {
    return _$getUserCarAsyncAction.run(() => super.getUserCar());
  }

  @override
  String toString() {
    return '''
userInfo: ${userInfo},
userCar: ${userCar}
    ''';
  }
}
