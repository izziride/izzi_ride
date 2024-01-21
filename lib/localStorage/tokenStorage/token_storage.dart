import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage{
  String accessToken="";
  
   getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String? refresh=  prefs.getString("refresh");
      refresh ??= "no";
      return  refresh;
}

setToken(String _accessToken, String refreshToken) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("-------");
  print(_accessToken);
  accessToken=_accessToken;
  print(accessToken);
  print("-------");
  await prefs.setString("refresh", refreshToken);
  return 1;
}
Future<void> clearSharedPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  
}

}

TokenStorage tokenStorage = TokenStorage();
