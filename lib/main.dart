import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:temp/localStorage/welcome/welcome.dart';
import 'package:temp/localization/localization.dart';
import 'package:temp/localization/localizationDelegats.dart';
import 'package:temp/pages/loader/loader_page.dart';
import 'package:temp/pages/main/main_page.dart';
import 'package:temp/pages/onboarding/onboarding_page.dart';
import 'package:temp/pages/registration/registration_page.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  try {
  //   FlutterError.onError = (FlutterErrorDetails details) {
  //   // Показываем попап с ошибкой
  //   showErrorDialog(details.exception.toString());
  // };
      WidgetsBinding widgetsBinding=WidgetsFlutterBinding.ensureInitialized();
      Locale locale= LocalizationManager.getCurrentLocale();
  int isWelcome =await FirstWelcome().getWelocme();
  runApp( MaterialApp(
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
        ),
        
    
  );
  } catch (e) {
    Dio().post(
      "https://ezride.requestcatcher.com/test",
      data: {
        "error":e
      }
    );
  }

    
  
}

