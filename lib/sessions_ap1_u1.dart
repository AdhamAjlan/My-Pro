import 'package:flutter/material.dart';
import 'code_ap1_u1_s1.dart'; // Corrected snake_case import

class SessionsAP1U1 extends StatelessWidget {
  final String title; // The unit title
  final String mainTitle; // The main title (e.g., O Level or A Level)

  const SessionsAP1U1({super.key, required this.title, required this.mainTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5E35B1),
        title: Text(
          '$mainTitle - $title',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFD1C4E9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            buildSessionCard(context, 'Session 1',
                'https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
            buildSessionCard(
                context, 'Session 2', 'https://www.youtube.com/watch?v=abc123'),
            buildSessionCard(
                context, 'Session 3', 'https://www.youtube.com/watch?v=xyz456'),
          ],
        ),
      ),
    );
  }

  Widget buildSessionCard(
      BuildContext context, String sessionTitle, String videoUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodeAP1U1S1(
              title: '$mainTitle - $title - $sessionTitle',
              videoUrl: videoUrl,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: const LinearGradient(
              colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.play_circle_fill,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sessionTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Watch video and study the session.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
