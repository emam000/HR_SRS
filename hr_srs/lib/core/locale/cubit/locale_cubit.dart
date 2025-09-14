import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hr_srs/core/database/cache_helper.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleInitial());

  Future<void> loadDeviceLocale() async {
    final savedLang = CacheHelper.getData(key: "localeLang");
    if (savedLang != null) {
      emit(ChangeLocaleSuccess(locale: Locale(savedLang)));
    } else {
      final systemLang =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      emit(ChangeLocaleSuccess(locale: Locale(systemLang)));
    }
  }

  Future<void> changeLocale(String langCode) async {
    await CacheHelper.saveData(key: "localeLang", value: langCode);
    emit(ChangeLocaleSuccess(locale: Locale(langCode)));
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == "ar";
  }
}
