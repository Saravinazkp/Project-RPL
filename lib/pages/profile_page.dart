import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigasi ke pengaturan atau logika lain
            },
          )
        ],
      ),
      body: ListView(
        children: [
          // Bagian header profil (foto profil dan statistik)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 40),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          profileStat('Posts', '50'),
                          profileStat('Followers', '1000'),
                          profileStat('Following', '200'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Informasi username dan bio
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:
                Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Text('Bio text goes here'),
          ),
          Divider(),
          // Grid foto di profil
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey[300],
                child: Center(child: Text('Photo')),
              );
            },
          )
        ],
      ),
    );
  }

  Widget profileStat(String label, String count) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label),
      ],
    );
  }
}
