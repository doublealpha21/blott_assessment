import 'package:flutter/material.dart';
import 'package:blott_asessment/models/news_model.dart';
import 'package:blott_asessment/services/news_service.dart';
import 'package:blott_asessment/services/user_data.dart';
import 'package:intl/intl.dart';
import 'error_page.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<List<NewsModel>> futureNews;
  String? firstName;

  @override
  void initState() {
    super.initState();
    final newsService = NewsService();
    futureNews = newsService.fetchNews();
    _loadFirstName();
  }

  Future<void> _loadFirstName() async {
    firstName = await UserDataManager.getFirstName();
    setState(() {});
  }

  String formatDate(String dateString) {
    int timestamp = int.parse(dateString);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final formatter = DateFormat('d MMMM yyyy');
    return formatter.format(date).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          firstName = 'Hey $firstName',
          style: const TextStyle(color: Colors.white),
        ),
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
                    subtitle: Text(
                      snapshot.data![index].headline,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data![index].source,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Text(
                          formatDate(snapshot.data![index].datetime.toString()),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ErrorPage(),
                        ),
                      );
                    });
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
