import 'package:ai_chatbot/feature/ai_chat/domain/ai_request_model.dart';
import 'package:hive/hive.dart';

part 'chats.g.dart';

@HiveType(typeId: 1)
class Chats extends HiveObject{
   @HiveField(0)
   final List<AiRequestModel> allChatsPerDay;
   Chats({required this.allChatsPerDay});
}