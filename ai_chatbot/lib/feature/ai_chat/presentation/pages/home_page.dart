import 'package:ai_chatbot/feature/ai_chat/data/chat_request_imp.dart';
import 'package:ai_chatbot/feature/ai_chat/domain/ai_request_model.dart';
import 'package:ai_chatbot/feature/ai_chat/domain/chat_repository_imp.dart';
import 'package:ai_chatbot/feature/ai_chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:ai_chatbot/feature/ai_chat/presentation/blocs/chat_history_bloc/chat_history_bloc.dart';
import 'package:ai_chatbot/feature/ai_chat/presentation/pages/chat_page.dart';
import 'package:ai_chatbot/feature/ai_chat/presentation/pages/drawer_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Widget> pages = [DrawerHistory(), ChatPage()];
  late AnimationController animationController;
  late Animation<double> slideAnimation;
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    slideAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (slideAnimation.value > 0.2 && slideAnimation.value < 0.4 ) {
            animationController.forward();
          }
          else if (slideAnimation.value < 0.8 && slideAnimation.value > 0.5) {
            animationController.reverse();
          }
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            animationController.value += details.primaryDelta! / 275;
          } else if (details.delta.dx < 0) {
            animationController.value += details.primaryDelta! / 275;
          }
        },
        child: Stack(
          children: [
            BlocProvider(
              create:
                  (context) { final bloc = ChatHistoryBloc(
                    chatBloc: context.read<ChatBloc>(),
                    
                  );
                  bloc.add(LoadChatHistoryByDay());
                  return bloc;
                  },
              child: DrawerHistory(),
            ),
            AnimatedBuilder(
              animation: slideAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(265 * slideAnimation.value, 0),
                  child: GestureDetector(
                    onTap: () {
                      if (animationController.isCompleted) {
                        animationController.reverse();
                      }
                    },
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text("AI Chat"),
                        leading: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            if (animationController.isCompleted) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                        ),
                      ),
                      body:  ChatPage(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
