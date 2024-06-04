import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
class LocatorPage extends StatefulWidget {
  const LocatorPage({super.key});

  @override
  State<LocatorPage> createState() => _LocatorPageState();
}

class _LocatorPageState extends State<LocatorPage> {

  static const String _isolateName = "LocatorIsolate";
  ReceivePort port = ReceivePort();

  start()async{
    var locationPermissionStatus = await Permission.location.request();
    print(locationPermissionStatus);
    if( locationPermissionStatus==PermissionStatus.denied){
      print("denied");
      return;
    }
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
    port.listen((dynamic data) {
      print(data);
      http.post(Uri.parse("http://192.168.1.138:3000/api"),headers: {},body: {
        "data":data
      });
    });
    initPlatformState();
  }

@override
  void initState() {
    super.initState();
    start();
    
  }
  
Future<void> initPlatformState() async {
    await BackgroundLocator.initialize();
    startLocationService();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
    );
  }

  void startLocationService()async{
    print("BackgroundLocator.registerLocationUpdate");
    bool isRunning= await BackgroundLocator.isServiceRunning();
    print("isRunning is "+isRunning.toString());
    BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: {},
        disposeCallback: LocationCallbackHandler.disposeCallback,
        autoStop: false,
        iosSettings: IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIcon: '',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
                    print("BackgroundLocator.registerLocationUpdate END");
}

}

mixin LocationCallbackHandler {

  @pragma('vm:entry-point')
static void callback(LocationDto locationDto) async {
  print("callback");
    final SendPort? send = IsolateNameServer.lookupPortByName("LocatorIsolate");
    final locationDtoJson = jsonEncode(locationDto);
    print(locationDtoJson);
    try {
      Dio().post("http://192.168.1.138:3000/api",
        data: {
          "data":locationDtoJson
        }
      );
    } catch (e) {
      
    }
    // http.post(Uri.parse("http://192.168.1.138:3000/api"),
    // body: {
    //     "data":"dsdsdd"
    //   },
    // headers: {
    //   "BUMS":"BUMS"
    // }
    // );
    send?.send(locationDtoJson);
}

//Optional
@pragma('vm:entry-point')
static void initCallback(dynamic _) {
    print('Plugin initialization');
}

@pragma('vm:entry-point')
static void disposeCallback() {
    print('Plugin disposeCallback');
}

//Optional
@pragma('vm:entry-point')
static void notificationCallback() {
    print('User clicked on the notification');
}
}