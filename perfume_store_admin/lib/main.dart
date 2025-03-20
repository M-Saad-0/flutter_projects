import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perfume_store_admin/app_theme.dart';
import 'package:perfume_store_admin/firebase_options.dart';
import 'package:perfume_store_admin/pages/home_page.dart';
import 'package:perfume_store_admin/pages/order_history.dart';
import 'package:perfume_store_admin/provider/order_provider.dart';
import 'package:perfume_store_admin/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
              create: (context) => ThemeProvider()),
          ChangeNotifierProvider<OrderProvider>(
              create: (context) => OrderProvider())
        ],
        child: Consumer<ThemeProvider>(builder: (context, value, child) {
          switch (value.isLoading) {
            case true:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case false:
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: value.isDark ? ThemeMode.dark : ThemeMode.light,
                routes: {

                  'history': (context) => const OrderHistory(),
                  'home': (context) => const HomePage(),

                  
                },
                home: const HomePage(),
              );
          }
        }));
  }
}
