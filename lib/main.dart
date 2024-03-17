import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:temp/localStorage/welcome/welcome.dart';
import 'package:temp/localization/localization.dart';
import 'package:temp/localization/localizationDelegats.dart';
import 'package:temp/pages/loader/loader_page.dart';
import 'package:temp/pages/main/main_page.dart';
import 'package:temp/pages/onboarding/onboarding_page.dart';
import 'package:temp/pages/registration/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';




GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  try {
  //   FlutterError.onError = (FlutterErrorDetails details) {
  //   // Показываем попап с ошибкой
  //   showErrorDialog(details.exception.toString());
  // };
      WidgetsBinding widgetsBinding=WidgetsFlutterBinding.ensureInitialized();
      
      
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);  
  FirebaseMessaging.instance.requestPermission();
  int isWelcome =await FirstWelcome().getWelocme();
  
  runApp(const App());
  } catch (e) {
    print(e);
    Dio().post(
      "https://ezride.requestcatcher.com/test",
      data: {
        "error":e
      }
    );
  }

    
  
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

Future<void> setupInteractedMessage(BuildContext context) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    inspect(initialMessage);
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(context,initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((messaage){
      _handleMessage(context,messaage);
    });
   
  }

  void _handleMessage(BuildContext context,RemoteMessage message) {
    inspect(message);
    Navigator.pushNamed(context, '/menu',
    );
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage(context);
  }


  @override
  Widget build(BuildContext context) {
    Locale locale= LocalizationManager.getCurrentLocale();
    return MaterialApp(
          theme: ThemeData(
             visualDensity: VisualDensity(vertical: -4),
             
          ),
          title: "iZZi Ride",
          navigatorKey: navigatorKey,
          initialRoute: "/loader",
          routes: {
            "/loader":(context) => Loader(),
            "/menu":(context) => const MainPage(),
            "/reg":(context) => const Registration(),
            "/onboard":(context) => Onboard()
          },
          locale: locale,
          supportedLocales: const[
             Locale("en","US"),
          ],
          localizationsDelegates:const [
            CustomLocalizationsDelegate()
          ],
        );
  }
}