part of 'locale_cubit.dart';

@immutable
sealed class LocaleState {}

final class LocaleInitial extends LocaleState {}

class ChangeLocaleSuccess extends LocaleState {
  final Locale locale;

  ChangeLocaleSuccess({required this.locale});
}
