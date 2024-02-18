// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_repo.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatsRepo on _ChatsRepo, Store {
  late final _$chatsAtom = Atom(name: '_ChatsRepo.chats', context: context);

  @override
  ObservableMap<String, ChatInfo> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableMap<String, ChatInfo> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$currentChatIdAtom =
      Atom(name: '_ChatsRepo.currentChatId', context: context);

  @override
  int get currentChatId {
    _$currentChatIdAtom.reportRead();
    return super.currentChatId;
  }

  @override
  set currentChatId(int value) {
    _$currentChatIdAtom.reportWrite(value, super.currentChatId, () {
      super.currentChatId = value;
    });
  }

  late final _$getChatsAsyncAction =
      AsyncAction('_ChatsRepo.getChats', context: context);

  @override
  Future<void> getChats() {
    return _$getChatsAsyncAction.run(() => super.getChats());
  }

  late final _$getChatAsyncAction =
      AsyncAction('_ChatsRepo.getChat', context: context);

  @override
  Future<void> getChat(int chatId) {
    return _$getChatAsyncAction.run(() => super.getChat(chatId));
  }

  late final _$addMessageAsyncAction =
      AsyncAction('_ChatsRepo.addMessage', context: context);

  @override
  Future<void> addMessage(Message message) {
    return _$addMessageAsyncAction.run(() => super.addMessage(message));
  }

  late final _$getMessageInchatsAsyncAction =
      AsyncAction('_ChatsRepo.getMessageInchats', context: context);

  @override
  Future<void> getMessageInchats(int chatId, int messageId) {
    return _$getMessageInchatsAsyncAction
        .run(() => super.getMessageInchats(chatId, messageId));
  }

  late final _$_ChatsRepoActionController =
      ActionController(name: '_ChatsRepo', context: context);

  @override
  void updateCurrentChatId(int updateValue) {
    final _$actionInfo = _$_ChatsRepoActionController.startAction(
        name: '_ChatsRepo.updateCurrentChatId');
    try {
      return super.updateCurrentChatId(updateValue);
    } finally {
      _$_ChatsRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic editStatus(
      String chatId, int status, String frontContentId, String time) {
    final _$actionInfo =
        _$_ChatsRepoActionController.startAction(name: '_ChatsRepo.editStatus');
    try {
      return super.editStatus(chatId, status, frontContentId, time);
    } finally {
      _$_ChatsRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic fullRead(String chatId) {
    final _$actionInfo =
        _$_ChatsRepoActionController.startAction(name: '_ChatsRepo.fullRead');
    try {
      return super.fullRead(chatId);
    } finally {
      _$_ChatsRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateUnreadInCHat(int chatId) {
    final _$actionInfo = _$_ChatsRepoActionController.startAction(
        name: '_ChatsRepo.updateUnreadInCHat');
    try {
      return super.updateUnreadInCHat(chatId);
    } finally {
      _$_ChatsRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteChat(int chatId) {
    final _$actionInfo =
        _$_ChatsRepoActionController.startAction(name: '_ChatsRepo.deleteChat');
    try {
      return super.deleteChat(chatId);
    } finally {
      _$_ChatsRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateStatusChat(int chatId) {
    final _$actionInfo = _$_ChatsRepoActionController.startAction(
        name: '_ChatsRepo.updateStatusChat');
    try {
      return super.updateStatusChat(chatId);
    } finally {
      _$_ChatsRepoActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chats: ${chats},
currentChatId: ${currentChatId}
    ''';
  }
}
