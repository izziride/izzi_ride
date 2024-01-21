class UserData{
  static Error err=Error();
  int clienId;
  int dateOfBirth;
  String photo;
  String name;
  String surname;
  String nickname;
  String gender;
  UserData({
    required this.clienId,
    required this.dateOfBirth,
    required this.gender,
    required this.name,
    required this.nickname,
    required this.photo,
    required this.surname
    });
}