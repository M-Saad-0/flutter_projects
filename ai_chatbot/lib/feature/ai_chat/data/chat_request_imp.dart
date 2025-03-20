import 'dart:convert';

import 'package:ai_chatbot/core/api_keys.dart';
import 'package:ai_chatbot/feature/ai_chat/domain/ai_request_model.dart';
import 'package:ai_chatbot/feature/ai_chat/domain/chat_request.dart';
import 'package:http/http.dart' as http;

class ChatRequestImp extends ChatRequest {
  @override
  Stream<String> postAiResponse(AiRequestModel model) async* {
    print("reqquestin");
    final Uri uri = Uri.parse(url);
    final request =
        http.Request("POST", uri)
          ..headers["Content-Type"] = "application/json"
          ..body = json.encode({
            'contents': [
              {
                "parts": [
                  {"text": model.query},
                ],
              },
            ],
          });

    try {
      final streamData = await http.Client().send(request);

      // ✅ Ensure status is OK before processing the stream
      if (streamData.statusCode == 200) {
        // ✅ Transform stream chunks properly
        yield* streamData.stream.transform(utf8.decoder).transform(json.decoder).map((e) {
          try {
            Map<String, dynamic> jsonStream = e as Map<String, dynamic>;
            // final candidates = jsonStream['cadidates'] as List<dynamic>;
            // if (candidates != null && candidates.isNotEmpty) {

            // }
            final text =
                jsonStream['candidates']
                    .first['content']['parts']
                    .first['text'];
            return text ?? "";
          } catch (e) {
            return "Error parsing response: $e";
          }
        });
      } else {
        throw Exception("Failed to fetch data: ${streamData.statusCode}");
      }
    } catch (e) {
      yield "Error: $e"; // ✅ Proper error handling
    }
  }
}
