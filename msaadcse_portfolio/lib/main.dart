import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:msaadcse_portfolio/app_theme.dart';
import 'package:msaadcse_portfolio/firebase_options.dart';
import 'package:msaadcse_portfolio/providers/github_contribution_provivder.dart';
import 'package:msaadcse_portfolio/providers/theme_provider.dart';
import 'package:msaadcse_portfolio/providers/visitor_provider.dart';
import 'package:msaadcse_portfolio/services/live_visitor_manager.dart';
import 'package:msaadcse_portfolio/views/homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  LiveVisitorManager().connect();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => GithubContributionProvivder()),
        ChangeNotifierProvider(
          create: (_) => VisitorProvider()..listenToVisitors(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder:
          (context, isDark, _) => MaterialApp(
            title: "Saad's Portfolio",
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            themeMode: isDark.isDark ? ThemeMode.dark : ThemeMode.light,
            home: Homepage(),
          ),
    );
  }
}
