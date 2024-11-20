import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailortape/firebase_options.dart';
import 'package:tailortape/provider/isdone_provider.dart';
import 'package:tailortape/provider/loading_provider.dart';
import 'package:tailortape/provider/theme_provider.dart';
import 'package:tailortape/theme/theme.dart';
import 'package:tailortape/ui/views/app_view/cutomer_view.dart';
import 'package:tailortape/ui/views/app_view/measurement_view.dart';
// import 'package:tailortape/ui/views/app_view/cutomer_view.dart';
// import 'package:tailortape/ui/views/app_view/measurement_view.dart';
import 'package:tailortape/ui/views/app_view/tailor_view.dart';
import 'package:tailortape/ui/views/auth/account_type_view.dart';
import 'package:tailortape/ui/views/auth/forgot_password.dart';
import 'package:tailortape/ui/views/auth/login_view.dart';
import 'package:tailortape/ui/views/auth/signup_cust_view.dart';
import 'package:tailortape/ui/views/auth/signup_view.dart';
import 'package:tailortape/ui/views/auth/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final val = ThemeProvider();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => LoadingProvider()),
          ChangeNotifierProvider(create: (context) => IsDone())
        ],
        child: Builder(
          builder: (context) {
            final themeChanger = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeChanger.themeName == "Light"
                  ? ThemeClass().lightTheme
                  : ThemeClass().darkTheme,
              darkTheme: ThemeClass().darkTheme,
              themeMode: themeChanger.themeName == "Light"
                  ? ThemeMode.light
                  : ThemeMode.dark,
              initialRoute: "splash",
              routes: {
                'splash': (context) => const SplashView(),
                'login': (context) => const LogInView(),
                'signup': (context) => const SignUpView(),
                'signup_customer': (context) => const SignUpCustView(),
                'account_type': (context) => const AcountTypeView(),
                'customer': (context) => const CustomerView(),
                'measurement': (context) => const MeasurementView(),
                'tailor': (context) => const TailorView(),
                'forgot_password': (context) => const ForgotPassword(),
              },
            );
          },
        ));
  }
}
