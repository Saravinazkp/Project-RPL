// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:rpl/data/db_provider.dart';
import 'package:rpl/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = DBProvider.db.select(DBProvider.db.users).getSingle();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userFuture,
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError || !snap.hasData) {
          return const Center(child: Text('Gagal memuat data user'));
        }
        final user = snap.data!;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        AssetImage('assets/avatar_placeholder.png'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        children: [
                          const TextSpan(text: 'Welcome back, '),
                          TextSpan(
                              text: user.username,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // KATEGORI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Event Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all >',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.emoji_events, color: Colors.white),
                    label: const Text('Competition'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.lightbulb, color: Colors.blue),
                    label: const Text('Upskill & Training'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // UPCOMING
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Competitions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See all >',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    EventCard(
                      imageAsset: 'assets/events/srifoton2024.png',
                      title: 'SRIFOTON 2024',
                      date: '10 Des 2024',
                    ),
                    EventCard(
                      imageAsset: 'assets/events/hackathon_xyz.png',
                      title: 'Hackathon XYZ',
                      date: '15 Jan 2025',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // RECENTLY VIEWED
              const Text(
                'Recently Viewed Events',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: const [
                  EventCard(
                    imageAsset: 'assets/events/srifoton2024.png',
                    title: 'SRIFOTON 2024',
                    date: '10 Des 2024',
                  ),
                  EventCard(
                    imageAsset: 'assets/events/ai_workshop.png',
                    title: 'AI Workshop',
                    date: '20 Feb 2025',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String date;

  const EventCard({
    Key? key,
    required this.imageAsset,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 180, // ★ tinggi tetap
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(right: 16, bottom: 16),
        child: Stack(
          children: [
            // gambar
            Positioned.fill(
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            // judul & tanggal
            Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            // icon favorit
            const Positioned(
              top: 16,
              right: 16,
              child: Icon(Icons.star_border, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
