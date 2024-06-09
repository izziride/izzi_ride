import 'package:flutter/material.dart';
import 'package:temp/models/preferences/preferences.dart';

class DataProvider extends ChangeNotifier {

  //2step

  int _carSeats=4;

  bool  _smoking= false;
  bool  _luggage=false;
  bool  _childCarSeat=false; 
  bool  _animals=false;


  int get carSeats => _carSeats;
  bool get smoking => _smoking;
  bool get luggage => _luggage;
  bool get childCarSeat => _childCarSeat;
  bool get animals => _animals;

  set carSeats(int value) {
    _carSeats = value;
    notifyListeners();
  }
  set smoking(bool value) {
    _smoking = value;
    notifyListeners();
  }
  set luggage(bool value) {
    _luggage = value;
    notifyListeners();
  }
  set childCarSeat(bool value) {
    _childCarSeat = value;
    notifyListeners();
  }
  set animals(bool value) {
    _animals = value;
    notifyListeners();
  }

  //1step
  bool _validManufacturer = true;
  bool _validModel = true;
  bool _validNumber = true;
  bool _validYear = true;
  bool get validManufacturer => _validManufacturer;
  bool get validModel => _validModel;
  bool get validNumber => _validNumber;
  bool get validYear => _validYear;
  set validManufacturer(bool value) {
    _validManufacturer = value;
    notifyListeners();
  }

  set validModel(bool value) {
    _validModel = value;
    notifyListeners();
  }

  set validNumber(bool value) {
    _validNumber = value;
    notifyListeners();
  }

  set validYear(bool value) {
    _validYear = value;
    notifyListeners();
  }

  String _carName="";
  int _carNameId=-1;
  String _carModel="";
  int _carModelId=-1;
  String _carNumber="";
  String _carYear="";

  String get carName => _carName;
  int get carNameId => _carNameId;
  String get carModel => _carModel;
  int get carModelId => _carModelId;
  String get carNumber => _carNumber;
  String get carYear => _carYear;

  // set validManufacturer(bool value) {
  //   validManufacturer = value;
  //   notifyListeners();
  // }

  // set validModel(bool value) {
  //   _validModel = value;
  //   notifyListeners();
  // }

  // set validNumber(bool value) {
  //   _validNumber = value;
  //   notifyListeners();
  // }

  // set validYear(bool value) {
  //   _validYear = value;
  //   notifyListeners();
  // }

  updateModel(String newModel,int modelId){
    _carModel=newModel;
    _carModelId=modelId;
    _validModel = true;
      notifyListeners(); 
  }

  updateName(String newName,int mnameId){
    _carName=newName;
    _carNameId=mnameId;
    _validManufacturer=true;
    notifyListeners(); 
  }

  updateCarNumber(String newNumber){
    _carNumber=newNumber;
    notifyListeners(); 
  }

  updateYear(String newYear){
    _carYear=newYear;
    notifyListeners(); 
  }
}