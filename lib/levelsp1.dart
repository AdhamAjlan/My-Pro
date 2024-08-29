import 'package:flutter/material.dart';
import 'units_ap1.dart';

class LevelsP1 extends StatelessWidget {
  final String title;

  const LevelsP1({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 77, 255, 1),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7C4DFF), Color(0xFF536DFE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select Your Level',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 60),
                buildNavigationButton(
                    context, 'O Level', Icons.school, 'O Level'),
                const SizedBox(height: 30),
                buildNavigationButton(
                    context, 'A Level', Icons.grade, 'A Level'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavigationButton(BuildContext context, String buttonText,
      IconData icon, String levelTitle) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFF7C4DFF),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
              horizontal: 24.0), // Text and icon color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF7C4DFF)),
            const SizedBox(width: 20),
            Text(
              buttonText,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C4DFF),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UnitsAP1(mainTitle: levelTitle),
            ),
          );
        },
      ),
    );
  }
}
