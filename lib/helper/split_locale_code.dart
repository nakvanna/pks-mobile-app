List<String> changeLocale(String localeCode) {
  List<String> splitLocaleCode = localeCode.split('_');
  return splitLocaleCode;
}

String getLangCode({required String localeCode}) {
  return changeLocale(localeCode)[0];
}

String getCountryCode({required String localeCode}) {
  return changeLocale(localeCode)[1];
}
