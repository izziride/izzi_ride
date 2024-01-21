import 'package:package_info_plus/package_info_plus.dart';

class AppInformation{
  String version="";

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
   
    version= packageInfo.version;
  }
}

AppInformation appInformation=AppInformation();