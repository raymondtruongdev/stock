import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_chart/consts.dart';
import 'package:stock_chart/logger_custom.dart';
import 'package:stock_chart/model/open_ai_data.dart';

class OpenAIBot {
  static List<Map<String, dynamic>> addHistoryOpenAIMessage({
    required var historyOpenAIMessage,
    required String role,
    required String content,
  }) {
    historyOpenAIMessage.add({
      "role": role,
      "content": content,
    });
    return historyOpenAIMessage;
  }

  static Future<String?> processData(var historyOpenAIMessage) async {
    String onlineMode = 'online';
    dynamic jsonData;
    switch (onlineMode) {
      case 'online':
        // Online mode will get request from server
        // String jsString = await makeSimplePostRequest(historyOpenAIMessage);
        String jsString = '';
        if (jsString.isNotEmpty) {
          jsonData = jsonDecode(jsString);
        } else {
          jsonData = null;
        }
        break;
      default:
        // Using data from a json in demo file
        jsonData = jsResponse1;
        // jsonData = null;
        // Simulate time delay to get data from Bot
        await Future.delayed(const Duration(milliseconds: 2000));
    }

    if (jsonData != null) {
      OpenAiData data = OpenAiData.fromJson(jsonData);
      List<Choice> choices = data.choices ?? [];
      String content = choices.isNotEmpty ? choices[0].message!.content! : '';
      String role = choices.isNotEmpty ? choices[0].message!.role! : '';

      return content;
    } else {
      return null;
    }
  }
}

Future<String> makeSimplePostRequest() async {
  CustomLogger logger = CustomLogger();
  String? jsonStr;

  /* Querry command
curl http://192.168.1.23:1234/v1/chat/completions \
-H "Content-Type: application/json" \
-d '{ 
  "messages": [ 
    { "role": "system", "content": "you are a helpful assistant" },
    { "role": "user", "content": " this year is 2024" },
  ], 
  "temperature": 0.7, 
  "max_tokens": -1,
  "stream": false
}';

*/
  List<Map<String, dynamic>> historyOpenAIMessage = [];
  historyOpenAIMessage.add({
    "role": "system",
    "content": "you are a helpful assistant",
  });
  historyOpenAIMessage.add({
    "role": "user",
    "content": "this year is 2024",
  });

  // Toan's computer Mijo
  var url = Uri.parse('http://192.168.1.14:1234/v1/chat/completions');

  var headers = {'Content-Type': 'application/json'};

  var body = jsonEncode({
    "messages": historyOpenAIMessage,
    "temperature": 0.7,
    "max_tokens": -1,
    "stream": false
  });

  http.Response response;
  try {
    response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Successful response
      logger.debug('Response: ${response.body}');
      jsonStr = response.body;
      logger.debug(jsonStr);
      return response.body;
    } else {
      // Error occurred
      logger.error('Error: ${response.statusCode}');
      return '';
    }
  } catch (e) {
    logger.error(e.toString());
    return '';
  }
}

Future<String> makePostRequest(String filePath) async {
  // return demoDelayReturnText(filePath);
  // Draft
  String strOutput = '';
  String filename = filePath;
  // filename =
  //     '/storage/emulated/0/Android/data/com.mijo.chatbot/files/trungle.wav';
  String url = 'http://192.168.1.23:5000/speech_to_text';
  http.MultipartRequest request;
  try {
    request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        filename,
        filename: filename.split("/").last,
      ),
    );
  } catch (e) {
    CustomLogger().error('Error in make http request: ${e.toString()}');
    return '';
  }

  try {
    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      var response = await http.Response.fromStream(streamedResponse);
      CustomLogger().debug('Response: ${response.body}');
      // Parse the JSON string
      Map<String, dynamic> data = jsonDecode(response.body);
      // Extract text
      strOutput = data['text'];
    } else {
      CustomLogger().error('Error: ${streamedResponse.reasonPhrase}');
    }
  } catch (e) {
    CustomLogger().error('Error: $e');
    // Demo return data when error to bypass process
    // String jsonData =
    //     '{"text": "m\\u1ed9t hai ba b\\u1ed1n n\\u0103m s\\u00e1u b\\u1ea3y t\\u00e1m ch\\u00edn m\\u01b0\\u1eddi."}';
    // Map<String, dynamic> data = jsonDecode(jsonData);
    // strOutput = data['text'];
  }
  return strOutput;
}
