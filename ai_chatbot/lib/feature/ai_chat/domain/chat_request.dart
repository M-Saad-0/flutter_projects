import 'package:ai_chatbot/feature/ai_chat/domain/ai_request_model.dart';

abstract class ChatRequest {
  Stream<String> postAiResponse(AiRequestModel model);
}