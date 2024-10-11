import 'package:flutter/material.dart';
import 'package:blott_asessment/models/news_model.dart';
import 'package:blott_asessment/services/news_service.dart';
import 'package:intl/intl.dart';
import 'error_page.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<NewsModel>> futureNews;

  @override
  void initState() {
    super.initState();
    final newsService = NewsService();
    futureNews = newsService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: FutureBuilder<List<NewsModel>>(
        future: futureNews,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(snapshot.data![index].image),
                  title: Text(snapshot.data![index].headline),
                  subtitle: Text(
                    '${snapshot.data![index].source} - ${snapshot.data![index].datetime}',
                  ),
                  onTap: () => ErrorPage(),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
