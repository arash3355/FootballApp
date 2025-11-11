import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class MatchCarousel extends StatelessWidget {
  const MatchCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Daftar gambar dan informasi pertandingannya
    final matches = [
      {
        'image':
            'https://images.unsplash.com/photo-1730816401327-1b6ce7b2a926?ixlib=rb-4.1.0&auto=format&fit=crop&q=80&w=1112',
        'title': 'Persib vs Persija',
      },
      {
        'image':
            'https://www.shutterstock.com/shutterstock/photos/2247981549/display_1500/stock-photo-stadium-soccer-football-match-championship-blue-team-players-attacks-plays-in-pass-action-game-2247981549.jpg',
        'title': 'Indonesia vs Kuwait',
      },
      {
        'image':
            'https://www.shutterstock.com/shutterstock/photos/2578181787/display_1500/stock-photo-soccer-athletes-dressed-sport-uniforms-challenging-for-soccer-ball-on-wet-grass-cleats-kicking-up-2578181787.jpg',
        'title': 'Real Madrid vs Barcelona',
      },
      {
        'image':
            'https://www.shutterstock.com/shutterstock/photos/1039736680/display_1500/stock-photo-soccer-player-kicking-ball-during-match-in-stadium-1039736680.jpg',
        'title': 'Liverpool vs Manchester United',
      },
      {
        'image':
            'https://www.shutterstock.com/shutterstock/photos/2452490349/display_1500/stock-photo-backview-of-fans-cheer-for-their-team-on-a-stadium-during-soccer-championship-match-teams-play-2452490349.jpg',
        'title': 'Arsenal vs Chelsea',
      },
    ];

    return Swiper(
      itemCount: matches.length,
      itemBuilder: (BuildContext context, int index) {
        final match = matches[index];

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 🖼️ Gambar latar
              Image.network(
                match['image']!,
                fit: BoxFit.cover,
              ),

              // 🌫️ Lapisan gelap transparan agar teks lebih jelas
              DecoratedBox(
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.3),
                ),
              ),

              // ✍️ Teks dan tombol di atas gambar
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Menonton ${match['title']}...'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Watch'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      autoplay: true,
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: const SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          activeColor: Colors.blue,
          color: Colors.grey,
          size: 6,
          activeSize: 8,
        ),
      ),
      control: const SwiperControl(color: Colors.white70),
    );
  }
}
