import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  final String author;
  final String date;

  const DetailPage({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.author,
    required this.date,
  });


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('NewsHub'),
      actions: [
        IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: () {
            
          },
        ),
      ],
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Utama
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul Berita
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                
                Text(
                  'By $author - $date',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
             
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.blueAccent),
            onPressed: () {
             
            },
          ),
          Text(
          '15k', 
          style: TextStyle(
            fontSize: 16, 
            color: Colors.blueAccent, 
          ),
        ),
          SizedBox(width: 15),
          IconButton(
            icon: Icon(Icons.comment, color: Colors.blueAccent),
            onPressed: () {
             
            },
          ),
          Text(
          '100', 
          style: TextStyle(
            fontSize: 16, 
            color: Colors.blueAccent, 
          ),
        ),
          SizedBox(width: 15),
          IconButton(
            icon: Icon(Icons.share, color: Colors.blueAccent),
            
            onPressed: () {
              // Aksi untuk share
            },
          ),
          Text(
          'Share', // Teks Share
          style: TextStyle(
            fontSize: 16, // Ukuran font
            color: Colors.blueAccent, // Warna teks
          ),
        ),
        ],
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
}

}
