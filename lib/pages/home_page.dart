import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Clone'),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              // Logika membuka kamera dapat ditambahkan di sini
            },
          )
        ],
      ),
      body: ListView(
        children: [
          // Bagian stories (carousel horizontal)
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.person, size: 30),
                      ),
                    ),
                    Text('User $index'),
                  ],
                );
              },
            ),
          ),
          // Bagian post
          ...List.generate(5, (index) {
            return PostWidget(postIndex: index);
          }),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final int postIndex;

  PostWidget({required this.postIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header post
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person),
            ),
            title: Text('User $postIndex'),
            subtitle: Text('Location'),
            trailing: Icon(Icons.more_vert),
          ),
          // Tampilan gambar post
          Container(
            height: 300,
            color: Colors.grey[200],
            child: Center(child: Text('Post Image')),
          ),
          // Bagian ikon interaksi
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 16),
                Icon(Icons.comment),
                SizedBox(width: 16),
                Icon(Icons.send),
                Spacer(),
                Icon(Icons.bookmark_border),
              ],
            ),
          ),
          // Keterangan post
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Liked by user1, user2 and others'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child:
                Text('View all comments', style: TextStyle(color: Colors.grey)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('2 hours ago',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
