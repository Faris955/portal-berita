import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_page.dart'; // Import DetailPage jika di file terpisah

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = '8880323a-caf2-45ce-a19e-a060d03a3b33';
  List<dynamic> news = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final url = Uri.parse(
        'https://content.guardianapis.com/search?api-key=$apiKey&show-fields=thumbnail,headline,byline,trailText');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        news = data['response']['results'];
      });
    } else {
      print('Failed to load news');
    }
  }

  String shortenText(String text, int maxLength) {
    return text.length > maxLength ? text.substring(0, maxLength) + '...' : text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewsHub'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Fungsi menu
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Fungsi pencarian
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Fungsi notifikasi
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        'https://picsum.photos/800/400?image=1',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'The Impact of AI on Modern Workplaces', // Judul statis atau bisa diambil dari API jika tersedia
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
              child: Text(
                'Breaking News',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          news.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final article = news[index];
                        final title = shortenText(article['fields']?['headline'] ?? 'No Title',30 );
                        final content = article['fields']?['trailText'] ?? 'No Description';
                        final description = shortenText(content,50);
                        
                        return GestureDetector(
                        onTap: () {
                        final fullTitle = article['fields']?['headline'] ?? 'No Title'; // Mengambil judul penuh
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: fullTitle, // Mengirimkan judul penuh ke DetailPage
                              content: content,
                              imageUrl: article['fields']?['thumbnail'] ?? 'https://via.placeholder.com/150',
                              author: article['fields']?['byline'] ?? 'Unknown Author',
                              date: '12 November 2024', // Atau gunakan tanggal dari API
                            ),
                          ),
                        );
                      },
                          child: Card(
                            margin: EdgeInsets.only(bottom: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: article['fields']?['thumbnail'] != null
                                        ? Image.network(
                                            article['fields']['thumbnail'],
                                            width: 100,
                                            height: 140,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            'https://via.placeholder.com/80',
                                            width: 100,
                                            height: 140,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          article['fields']?['byline'] ?? 'Unknown Author',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: news.length,
                    ),
                  ),
                ),
        ],
      ),
     bottomNavigationBar: Padding(
  padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
  child: BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Categories',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    iconSize: 25.0, // Ukuran ikon
    selectedItemColor: Colors.blueAccent,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
),

    );
  }
}
