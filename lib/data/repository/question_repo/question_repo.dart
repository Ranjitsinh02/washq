import 'package:http/http.dart';
import 'package:washq/common_widget/network_handler.dart';

class QuestionRepository {
  NetworkHandler networkHandler = NetworkHandler();

  Future<Response> getQuestions(Map<String, dynamic> body) async {
    String endPoint = '/get_section_questions';

    var response = await networkHandler.postRequest(endPoint, parameters: body);
    return response;
  }

}
