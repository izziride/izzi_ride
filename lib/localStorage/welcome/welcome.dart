import 'package:shared_preferences/shared_preferences.dart';

class FirstWelcome{
  Future<int> getWelocme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? welcome=  prefs.getInt("welcome");
      if(welcome==null){
        return 0;
      }else {
        return welcome;
      }
}

Future<int> setWelcome() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("welcome", 1);
  return 1;
}

Future<void> clearSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
 
}
}