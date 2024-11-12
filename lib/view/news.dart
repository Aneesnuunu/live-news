import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String url;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFF003366), // Dark Blue
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image of the article
            Image.network(
              widget.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/placeholder.png', // Placeholder image
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121), // Dark Gray Text
                    ),
                  ),
                  SizedBox(height: 10),
                  // Article description
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF757575), // Light Gray Text
                    ),
                  ),
                  SizedBox(height: 20),
                  // Read more link (if needed)
                  GestureDetector(
                    onTap: () {
                      // You can open the full article in the browser or a WebView
                      if (widget.url.isNotEmpty) {
                        // Launch the URL in a browser or WebView
                        // You might want to use a package like 'url_launcher' to handle this
                      }
                    },
                    child: Text(
                      'Read full article',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
