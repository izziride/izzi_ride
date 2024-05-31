import 'package:shared_preferences/shared_preferences.dart';

class RateModalStorage{
  Future<String> getRate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? welcome=  prefs.getString("rate_modal");
      if(welcome==null){
        return "-";
      }else {
        return welcome;
      }
}

Future<int> setRate() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("rate_modal", "+");
  return 0;
}

Future<void> clearSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
 
}
}