import 'package:ai_chatbot/feature/ai_chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:ai_chatbot/feature/ai_chat/presentation/blocs/chat_history_bloc/chat_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerHistory extends StatefulWidget {
  const DrawerHistory({super.key});

  @override
  State<DrawerHistory> createState() => _DrawerHistoryState();
}

class _DrawerHistoryState extends State<DrawerHistory> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<ChatHistoryBloc>().add(LoadChatHistoryByDay());
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Your Name'),
            ),
            BlocBuilder<ChatHistoryBloc, ChatHistoryState>(
              builder: (context, state) {
                switch (state) {
                  case ChatHistoryLoading():
                    return Center(child: CircularProgressIndicator());
                  case ChatHistoryError():
                    return Center(child: Text(state.message));
                  case ChatHistoryLoaded():
                    return Column(
                      children:
                          state.keys
                              .map(
                                (key) => ListTile(
                                  leading: Icon(Icons.history),
                                  title: Text(key.split("T")[0]),
                                  onTap: ()async{
                                    context.read<ChatHistoryBloc>().add(LoadChatHistoryOfADay(key));
                                  },
                                ),
                              )
                              .toList(),
                    );
                  default:
                    return Center(child: Text('No chat history found'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
