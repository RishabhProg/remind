import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApi {
  String? res;

  Future<String> geminiTxt() async {
    await dotenv.load(fileName: ".env");

    String apiKey = dotenv.env['API_KEY'] ?? '';

// Access your API key as an environment variable (see "Set up your API key" above)
    // final apiKey = Platform.environment[api];
    if (apiKey == null) {
      print('No \$API_KEY environment variable');
      exit(1);
    }
// Make sure to include this import:
// import 'package:google_generative_ai/google_generative_ai.dart';
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
    final prompt = res;

    final response = await model.generateContent([Content.text(prompt!)]);

    //print(response.text);
    return response.text ?? "No response";
  }
}
