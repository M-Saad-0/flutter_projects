import 'package:ai_chatbot/core/app_theme.dart';
import 'package:ai_chatbot/feature/ai_chat/data/chat_request_imp.dart';
import 'package:ai_chatbot/feature/ai_chat/domain/ai_request_model.dart';
import 'package:ai_chatbot/feature/ai_chat/domain/chat_repository_imp.dart';
import 'package:ai_chatbot/feature/ai_chat/domain/chats.dart';
import 'package:ai_chatbot/feature/ai_chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:ai_chatbot/feature/ai_chat/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatsAdapter());
  Hive.registerAdapter(AiRequestModelAdapter());
  await Hive.openBox<Chats>('chats');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.darkTheme,
      home: BlocProvider(
        create: (context) => ChatBloc(ChatRequestImp(), ChatRepositoryImp()),
        child: const HomePage(),
      ),
    );
  }
}