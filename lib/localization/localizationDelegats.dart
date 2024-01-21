import 'package:flutter/material.dart';
import 'package:temp/localization/localization.dart';

class CustomLocalizationsDelegate extends LocalizationsDelegate<LocalizationManager> {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    if(
      locale.languageCode=="en"&&locale.countryCode=="US"
    ){
      return true;
    }
    return false;
  }

  @override
  Future<LocalizationManager> load(Locale locale) async {
    LocalizationManager localizationManager=LocalizationManager();
    await localizationManager.loadTranslations(locale);
    return localizationManager;
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) {
   return false;
  }
}


