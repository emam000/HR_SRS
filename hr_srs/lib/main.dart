import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hr_srs/core/database/cache_helper.dart';
import 'package:hr_srs/core/locale/cubit/locale_cubit.dart';
import 'package:hr_srs/core/sizeconfig/size_config.dart';
import 'package:hr_srs/core/theme/theme.dart';
import 'package:hr_srs/features/hr/add_and%20_edit_employees/view_model/cubit/employee_cubit.dart';
import 'package:hr_srs/features/hr/attendance/view_model/cubit/attendance_cubit.dart';
import 'package:hr_srs/features/hr/groups_and_prmi/view_model/cubit/groups_cubit.dart';
import 'package:hr_srs/features/hr/payroll/view_model/cubit/payroll_cubit.dart';
import 'package:hr_srs/features/splash/views/splash_view.dart';
import 'package:hr_srs/features/hr/users/view_model/cubit/users_cubit.dart';
import 'package:hr_srs/features/auth/view_model/cubit/auth_cubit.dart';
import 'package:hr_srs/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.inital();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()..loadDeviceLocale()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => EmployeeCubit()),
        BlocProvider(create: (context) => UsersCubit()),
        BlocProvider(create: (context) => AttendanceCubit()),
        BlocProvider(create: (context) => PayrollCubit()),
        BlocProvider(create: (context) => GroupsCubit()),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashView(),
            theme: appTheme,
            locale: state is ChangeLocaleSuccess ? state.locale : null,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}
