import 'package:ai_chatbot/feature/ai_chat/domain/chat_repository_imp.dart';
import 'package:ai_chatbot/feature/ai_chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_history_event.dart';
part 'chat_history_state.dart';

class ChatHistoryBloc extends Bloc<ChatHistoryEvent, ChatHistoryState> {
  ChatBloc chatBloc;
  ChatHistoryBloc({required this.chatBloc}) : super(ChatHistoryInitial()) {
    on<LoadChatHistoryByDay>((event, emit) async {
      emit(ChatHistoryLoading());
      try {
        List<String> getKeys = await chatBloc.chatRepositoryImp.getChatKeys();
        emit(ChatHistoryLoaded(getKeys));
      } catch (error) {
        emit(ChatHistoryError(error.toString()));
      }
    });

    on<LoadChatHistoryOfADay>((event, emit) async {
      chatBloc.updateChatHistory =
          (await chatBloc.chatRepositoryImp.getEntireChat(
            event.key,
          )).allChatsPerDay;
    });
  }
}
