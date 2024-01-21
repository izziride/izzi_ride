import 'package:temp/models/preferences/preferences.dart';

class UserCar{
  int carId;
  int numberOfSeats;
  String model;
  String manufacturer;
  String autoNumber;
  String color;
  String year;
  Preferences preferences;
  UserCar({
    required this.carId,
    required this.numberOfSeats,
    required this.model,
    required this.manufacturer,
    required this.autoNumber,
    required this.color,
    required this.year,
    required this.preferences
  });
}