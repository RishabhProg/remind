import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApi {
  String? res;

  Future<String> geminiTxt() async {
    await dotenv.load(fileName: ".env");

    String apiKey = dotenv.env['API_KEY'] ?? '';


    if (apiKey == null) {
      print('No \$API_KEY environment variable');
      exit(1);
    }

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
