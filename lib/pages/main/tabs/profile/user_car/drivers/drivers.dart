import 'package:flutter/material.dart';

class UserCarDrivers{
  final FocusNode _numberFocusNode=FocusNode();
  final FocusNode _yearFocusNode=FocusNode();

  FocusNode get numberFocusNode=>_numberFocusNode;
  FocusNode get yearFocusNode=>_yearFocusNode;

  dispose(){
    _numberFocusNode.dispose();
    _yearFocusNode.dispose();
  }
}