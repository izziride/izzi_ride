import 'package:mobx/mobx.dart';

part 'create_repo.g.dart';

class CreateRepo = _CreateRepo with _$CreateRepo;

abstract class _CreateRepo with Store {

  
  @observable
  String fromCity="";

  @observable
  String fromState="";

  @observable
  int fromCityId=0;

  @observable
  double fromLat=0;

  @observable
  double fromLng=0;

  @observable
  String toCity="";

  @observable
  String toState="";

  @observable
  int toCityId=0;

  @observable
  double toLat=0;

  @observable
  double toLng=0;

  @observable
  DateTime date=DateTime.now();

  @observable
  DateTime time=DateTime.now();

  String generateCurrentDateTimeString(){
    DateTime gen = date.copyWith(hour:time.hour,minute: time.minute );
    return gen.toIso8601String();
  }

  @observable
  int personCount=1;

  @action
  void updateFromCity(String updatedValue) {
    print("updateFromCity->$updatedValue");
    fromCity = updatedValue;
  }

  @action
  void updateFromState(String updatedValue) {
    fromState = updatedValue;
  }

  @action
  void updateFromLat(double updatedValue) {
    fromLat = updatedValue;
  }

  @action
  void updateFromLng(double updatedValue) {
    fromLng= updatedValue;
  }

  @action
  void updateFromCityId(int updatedValue) {
    fromCityId = updatedValue;
  }

  @action
  void updateToCity(String updatedValue) {
    toCity = updatedValue;
  }

  @action
  void updateToState(String updatedValue) {
    toState = updatedValue;
  }

  @action
  void updateToLat(double updatedValue) {
    toLat = updatedValue;
  }

  @action
  void updateToLng(double updatedValue) {
    toLng= updatedValue;
  }

  @action
  void updateToCityId(int updatedValue) {
    toCityId = updatedValue;
  }

  @action
  void updateDate(DateTime updatedValue) {
    date = updatedValue;
  }

  @action
  void updateTime(DateTime updatedValue) {
    time = updatedValue;
  }

  @action
  void updatePersonCount(int updatedValue) {
    personCount = updatedValue;
  }
  //Preferences value
  @observable
  bool smoking=false;
  @observable
  bool luggage=false; 
  @observable
  bool childCarSeat=false;
  @observable
  bool animals=false;
   @observable

  @action
  updateSmoking(bool updatedValue){
    smoking=updatedValue;
  }
  @action
  updateLuggage(bool updatedValue){
    luggage=updatedValue;
  }
  @action
  updateChildCarSeat(bool updatedValue){
    childCarSeat=updatedValue;
  }
  @action
  updateAnimals(bool updatedValue){
    animals=updatedValue;
  }
  @observable
  String carName="";
  @observable
  String carModel="";
  @observable
  String carNumber="";
  @observable
  String carYear="";
  @observable
  int carNameId=-1;
  @observable
  int carModelId=-1;
  @action
  updateCarNamet(String updatedValue,int updatedValueId){
    carName=updatedValue;
    carNameId=updatedValueId;
  }
  @action
  updateCarModel(String updatedValue,int updatedValueId){
    carModel=updatedValue;
    carModelId=updatedValueId;
  }

  @action
  updateCarNumber(String updatedValue){
    carNumber=updatedValue;
  }

  @action
  updateCarYear(String updatedValue){
    carYear=updatedValue;
  }
  @observable
  int numberSeats=0;
  @action
  updateNuberSeats(int updatedValue){
    numberSeats=updatedValue;
  }

  @observable
  String comment="";
  @action
  updateComment(String updatedValue){
    comment=updatedValue;
  }

}

 
CreateRepo createRepo = CreateRepo();