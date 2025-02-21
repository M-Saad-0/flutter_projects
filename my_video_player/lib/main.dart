import 'package:flutter/material.dart';
import 'package:my_video_player/pages/home_page.dart';
import 'package:my_video_player/providers/video_provider.dart';
import 'package:my_video_player/theme/app_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  var status = await Permission.storage.status;
                  if (!status.isGranted) {
                    await Permission.storage.request();
                    await Permission.manageExternalStorage.request();
                  }
  runApp(MultiProvider(
    providers: [
      ListenableProvider(create: (context)=>VideoProvider())
    ],
    child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData,
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}