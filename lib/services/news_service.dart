import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blott_asessment/models/news_model.dart';

class NewsService {
  static const String _baseUrl = 'https://finnhub.io/api/v1/news?category=general&token=crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';
  final http.Client client;

  NewsService({http.Client? client}) : this.client = client ?? http.Client();

  Future<List<NewsModel>> fetchNews() async {
    final response = await client.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => NewsModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
