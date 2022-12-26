import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openai_chat/api_constants.dart';

class OpenAiRepository {
  static var client = http.Client();

  static Future<Map<String, dynamic>> sendMessage({required prompt}) async {
    try {
      var headers = {
        'Authorization': 'Bearer $aiToken',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse('${endpoint}completions'));
      request.body = json.encode({
        "model": "text-davinci-003",
        "prompt": prompt,
        "temperature": 0,
        "max_tokens": 2000
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();

        return json.decode(data);
      } else {
        return {
          "status": false,
          "message": "Oops, there was an error",
        };
      }
    } catch (_) {
      return {
        "status": false,
        "message": "Oops, there was an error",
      };
    }
  }
}
