import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:perfume_store/app_theme.dart';
import 'package:perfume_store/firebase_options.dart';
import 'package:perfume_store/models/order.dart';
import 'package:perfume_store/models/user.dart';
import 'package:perfume_store/pages/cart_page.dart';
import 'package:perfume_store/pages/home_page.dart';
import 'package:perfume_store/pages/order_page.dart';
import 'package:perfume_store/pages/product_detail_page.dart';
import 'package:perfume_store/pages/sign_in_page.dart';
import 'package:perfume_store/pages/sign_up_page.dart';
import 'package:perfume_store/provider/cart_provider.dart';
import 'package:perfume_store/provider/order_provider.dart';
import 'package:perfume_store/provider/theme_provider.dart';
import 'package:perfume_store/provider/user_provider.dart';
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
          ChangeNotifierProvider<CartProvider>(
              create: (context) => CartProvider()),
          ChangeNotifierProvider<MyUserProvider>(
              create: (context) => MyUserProvider()),
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
                  'sign-in': (context) => const SignInPage(),
                  'sign-up': (context) => const SignUpPage(),
                  'welcome': (context) => const WelcomePage(),
                  'cart': (context) => const CartPage(),
                  'home': (context) => const HomePage(),
                  'product': (context) {
                    final args = ModalRoute.of(context)!.settings.arguments
                        as Map<String, dynamic>;

                    return ProductDetailPage(
                      item: args['item'] as Map<String, dynamic>,
                      user: args['user'] as MyUser?,
                    );
                  },
                  'order': (context) => const OrderPage(),
                },
                home: const HomePage(),
              );
          }
        }));
  }
}
