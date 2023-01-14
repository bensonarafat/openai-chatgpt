import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openai_chat/api_constants.dart';

/// OpenAPI Repository
class OpenAiRepository {
  /// HTTP Client
  static http.Client client = http.Client();

  /// Sends OpenAPI request.
  static Future<Map<String, dynamic>> sendMessage({required String prompt})
    async {
    try {
      final headers = {
        'Authorization': 'Bearer $aiToken',
        'Content-Type': 'application/json'
      };
      final request = http.Request('POST', Uri.parse('${endpoint}completions'))
      ..body = json.encode({
        'model': 'text-davinci-003',
        'prompt': prompt,
        'temperature': 0,
        'max_tokens': 2000
      });
      request.headers.addAll(headers);

      final response = await request.send();
      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();

        return json.decode(data) as Map<String, dynamic>;
      } else {
        return {
          'status': false,
          'message': 'Oops, there was an error',
        };
      }
    } catch (_) {
      return {
        'status': false,
        'message': 'Oops, there was an error',
      };
    }
  }
}
