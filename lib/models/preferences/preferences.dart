class Preferences{
  bool smoking;
  bool luggage;
  bool childCarSeat;
  bool animals;
  Preferences({
    required this.smoking,
    required this.luggage,
    required this.childCarSeat,
    required this.animals
  });

  Map<String,dynamic> toJson(){
    return {
      "smoking":smoking,
      "luggage":luggage,
      "child_car_seat":childCarSeat,
      "animals":animals
    };
  }
}