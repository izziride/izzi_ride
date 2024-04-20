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
  ObservableList<UserCar>? get userCar {
    _$userCarAtom.reportRead();
    return super.userCar;
  }

  @override
  set userCar(ObservableList<UserCar>? value) {
    _$userCarAtom.reportWrite(value, super.userCar, () {
      super.userCar = value;
    });
  }

  late final _$carHasErrorAtom =
      Atom(name: '_UserRepo.carHasError', context: context);

  @override
  bool get carHasError {
    _$carHasErrorAtom.reportRead();
    return super.carHasError;
  }

  @override
  set carHasError(bool value) {
    _$carHasErrorAtom.reportWrite(value, super.carHasError, () {
      super.carHasError = value;
    });
  }

  late final _$userOrdersAtom =
      Atom(name: '_UserRepo.userOrders', context: context);

  @override
  ObservableList<DriverOrder> get userOrders {
    _$userOrdersAtom.reportRead();
    return super.userOrders;
  }

  @override
  set userOrders(ObservableList<DriverOrder> value) {
    _$userOrdersAtom.reportWrite(value, super.userOrders, () {
      super.userOrders = value;
    });
  }

  late final _$isFirstLoadedAtom =
      Atom(name: '_UserRepo.isFirstLoaded', context: context);

  @override
  bool get isFirstLoaded {
    _$isFirstLoadedAtom.reportRead();
    return super.isFirstLoaded;
  }

  @override
  set isFirstLoaded(bool value) {
    _$isFirstLoadedAtom.reportWrite(value, super.isFirstLoaded, () {
      super.isFirstLoaded = value;
    });
  }

  late final _$isFirstLoadedBookedAtom =
      Atom(name: '_UserRepo.isFirstLoadedBooked', context: context);

  @override
  bool get isFirstLoadedBooked {
    _$isFirstLoadedBookedAtom.reportRead();
    return super.isFirstLoadedBooked;
  }

  @override
  set isFirstLoadedBooked(bool value) {
    _$isFirstLoadedBookedAtom.reportWrite(value, super.isFirstLoadedBooked, () {
      super.isFirstLoadedBooked = value;
    });
  }

  late final _$userBookedOrdersAtom =
      Atom(name: '_UserRepo.userBookedOrders', context: context);

  @override
  ObservableList<DriverOrder> get userBookedOrders {
    _$userBookedOrdersAtom.reportRead();
    return super.userBookedOrders;
  }

  @override
  set userBookedOrders(ObservableList<DriverOrder> value) {
    _$userBookedOrdersAtom.reportWrite(value, super.userBookedOrders, () {
      super.userBookedOrders = value;
    });
  }

  late final _$userOrderFullInformationAtom =
      Atom(name: '_UserRepo.userOrderFullInformation', context: context);

  @override
  UserOrderFullInformation? get userOrderFullInformation {
    _$userOrderFullInformationAtom.reportRead();
    return super.userOrderFullInformation;
  }

  @override
  set userOrderFullInformation(UserOrderFullInformation? value) {
    _$userOrderFullInformationAtom
        .reportWrite(value, super.userOrderFullInformation, () {
      super.userOrderFullInformation = value;
    });
  }

  late final _$userOrderFullInformationErrorAtom =
      Atom(name: '_UserRepo.userOrderFullInformationError', context: context);

  @override
  bool get userOrderFullInformationError {
    _$userOrderFullInformationErrorAtom.reportRead();
    return super.userOrderFullInformationError;
  }

  @override
  set userOrderFullInformationError(bool value) {
    _$userOrderFullInformationErrorAtom
        .reportWrite(value, super.userOrderFullInformationError, () {
      super.userOrderFullInformationError = value;
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

  late final _$getUserOrdersAsyncAction =
      AsyncAction('_UserRepo.getUserOrders', context: context);

  @override
  Future<void> getUserOrders() {
    return _$getUserOrdersAsyncAction.run(() => super.getUserOrders());
  }

  late final _$getUserBookedOrdersAsyncAction =
      AsyncAction('_UserRepo.getUserBookedOrders', context: context);

  @override
  Future<void> getUserBookedOrders() {
    return _$getUserBookedOrdersAsyncAction
        .run(() => super.getUserBookedOrders());
  }

  late final _$editStatusOrderAsyncAction =
      AsyncAction('_UserRepo.editStatusOrder', context: context);

  @override
  Future<void> editStatusOrder(int orderId, String newStatus) {
    return _$editStatusOrderAsyncAction
        .run(() => super.editStatusOrder(orderId, newStatus));
  }

  late final _$cancelBookedOrderByUserAsyncAction =
      AsyncAction('_UserRepo.cancelBookedOrderByUser', context: context);

  @override
  Future<void> cancelBookedOrderByUser(int orderId) {
    return _$cancelBookedOrderByUserAsyncAction
        .run(() => super.cancelBookedOrderByUser(orderId));
  }

  late final _$getUserFullInformationOrderAsyncAction =
      AsyncAction('_UserRepo.getUserFullInformationOrder', context: context);

  @override
  Future<void> getUserFullInformationOrder(int orderId) {
    return _$getUserFullInformationOrderAsyncAction
        .run(() => super.getUserFullInformationOrder(orderId));
  }

  late final _$getUserFullInformationOrderWithouOrderIdAsyncAction =
      AsyncAction('_UserRepo.getUserFullInformationOrderWithouOrderId',
          context: context);

  @override
  Future<void> getUserFullInformationOrderWithouOrderId() {
    return _$getUserFullInformationOrderWithouOrderIdAsyncAction
        .run(() => super.getUserFullInformationOrderWithouOrderId());
  }

  late final _$deleteUserByOrderAsyncAction =
      AsyncAction('_UserRepo.deleteUserByOrder', context: context);

  @override
  Future<void> deleteUserByOrder(int orderId, int clientId) {
    return _$deleteUserByOrderAsyncAction
        .run(() => super.deleteUserByOrder(orderId, clientId));
  }

  late final _$cancelOrderAsyncAction =
      AsyncAction('_UserRepo.cancelOrder', context: context);

  @override
  Future<int> cancelOrder(int orderId, String comment) {
    return _$cancelOrderAsyncAction
        .run(() => super.cancelOrder(orderId, comment));
  }

  late final _$deleteUserByAsyncAction =
      AsyncAction('_UserRepo.deleteUserBy', context: context);

  @override
  Future<int> deleteUserBy(int orderId, String comment) {
    return _$deleteUserByAsyncAction
        .run(() => super.deleteUserBy(orderId, comment));
  }

  late final _$_UserRepoActionController =
      ActionController(name: '_UserRepo', context: context);

  @override
  void CLEANUSERREPO() {
    final _$actionInfo = _$_UserRepoActionController.startAction(
        name: '_UserRepo.CLEANUSERREPO');
    try {
      return super.CLEANUSERREPO();
    } finally {
      _$_UserRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addUserOrders(DriverOrder order) {
    final _$actionInfo = _$_UserRepoActionController.startAction(
        name: '_UserRepo.addUserOrders');
    try {
      return super.addUserOrders(order);
    } finally {
      _$_UserRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editUserOrdersSeatsInOrder(int orderId, String type) {
    final _$actionInfo = _$_UserRepoActionController.startAction(
        name: '_UserRepo.editUserOrdersSeatsInOrder');
    try {
      return super.editUserOrdersSeatsInOrder(orderId, type);
    } finally {
      _$_UserRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteUserBookedOrders(int orderId) {
    final _$actionInfo = _$_UserRepoActionController.startAction(
        name: '_UserRepo.deleteUserBookedOrders');
    try {
      return super.deleteUserBookedOrders(orderId);
    } finally {
      _$_UserRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userInfo: ${userInfo},
userCar: ${userCar},
carHasError: ${carHasError},
userOrders: ${userOrders},
isFirstLoaded: ${isFirstLoaded},
isFirstLoadedBooked: ${isFirstLoadedBooked},
userBookedOrders: ${userBookedOrders},
userOrderFullInformation: ${userOrderFullInformation},
userOrderFullInformationError: ${userOrderFullInformationError}
    ''';
  }
}
