import 'package:mobx/mobx.dart';

part 'search_repo.g.dart';

class SearchRepo = _SearchRepo with _$SearchRepo;

abstract class _SearchRepo with Store {

  
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
  void updatePersonCount(int updatedValue) {
    personCount = updatedValue;
  }
}

 
SearchRepo searchRepo = SearchRepo();