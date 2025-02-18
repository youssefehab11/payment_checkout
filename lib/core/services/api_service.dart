import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> post({
    required String url,
    required Map<String, dynamic> body,
    required apiKey,
  }) async {
    Response response = await _dio.post(
      url,
      data: body,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer $apiKey'},
      ),
    );
    return response;
  }
}
