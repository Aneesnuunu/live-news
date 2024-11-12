import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';
import 'news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    newsProvider.fetchArticles('');
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The Daily Pulse',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF003366), // Dark Blue
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 10.0,
                children: [
                  'All', 'Business', 'Entertainment', 'Health', 'Sports', "Technology", 'Science', 'Politics',
                ]
                    .map((category) => ChoiceChip(
                  label: Text(category),
                  selected: newsProvider.currentCategory == category.toLowerCase() || (category == 'All' && newsProvider.currentCategory == ''),
                  onSelected: (selected) {
                    if (category == 'All') {
                      newsProvider.fetchArticles('');
                    } else {
                      newsProvider.fetchArticles(category.toLowerCase());
                    }
                    newsProvider.setCurrentCategory(category == 'All' ? '' : category.toLowerCase());
                  },
                  selectedColor: Colors.pink[400],
                  backgroundColor: Colors.grey[300],
                  labelStyle: TextStyle(
                    color: newsProvider.currentCategory == category.toLowerCase() || (category == 'All' && newsProvider.currentCategory == '')
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: newsProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : newsProvider.articles.isEmpty
                ? Center(child: Text('No articles found.', style: TextStyle(fontSize: 18, color: Colors.black54)))
                : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: newsProvider.articles.length,
              itemBuilder: (context, index) {
                final article = newsProvider.articles[index];

                if (article.title.isEmpty ||
                    article.description.isEmpty ||
                    article.urlToImage.isEmpty) {
                  return SizedBox.shrink();
                }

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        article.urlToImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/placeholder.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    title: Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121),
                      ),
                    ),
                    subtitle: Text(
                      article.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF757575),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(
                            title: article.title,
                            description: article.description,
                            imageUrl: article.urlToImage,
                            url: article.url,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
