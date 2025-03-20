import 'package:ai_chatbot/feature/ai_chat/domain/ai_request_model.dart';
import 'package:ai_chatbot/feature/ai_chat/domain/chats.dart';

abstract class ChatRepository {
  Future<void> saveChat(List<AiRequestModel> models);

  Future<List<String>> getChatKeys();

  Future<Chats> getEntireChat(String key);

  Future<void> deleteEntireChat(String key);
}
