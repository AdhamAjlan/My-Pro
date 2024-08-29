import 'package:flutter/material.dart';
import 'sessions_ap1_u1.dart';

class UnitsAP1 extends StatelessWidget {
  final String
      mainTitle; // The dynamic title passed from LevelsP1 (O Level or A Level)

  UnitsAP1({super.key, required this.mainTitle});

  // Static list of units for the selected level
  final List<String> units = [
    "Unit 1",
    "Unit 2",
    "Unit 3",
    "Unit 4",
    "Unit 5",
    "Unit 6",
    "Revision 1",
    "Revision 2",
    "Unit 7",
    "Unit 8",
    "Unit 9",
    "Unit 10",
    "Unit 11",
    "Unit 12",
    "Revision 3",
    "Revision 4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5E35B1),
        title: Text(
          mainTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color(0xFFF3E5F5),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.5,
          ),
          itemCount: units.length,
          itemBuilder: (context, index) {
            return buildUnitCard(context, units[index]);
          },
        ),
      ),
    );
  }

  Widget buildUnitCard(BuildContext context, String unitTitle) {
    // Check if the unit is a revision based on the title
    bool isRevision = unitTitle.contains('Revision');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SessionsAP1U1(
              title: unitTitle,
              mainTitle: mainTitle,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: isRevision ? Matrix4.rotationZ(0.05) : Matrix4.rotationZ(0),
        decoration: BoxDecoration(
          borderRadius: isRevision
              ? BorderRadius.circular(50)
              : BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: isRevision
                ? [
                    const Color(0xFF5E35B1),
                    const Color(0xFF5E35B1)
                  ] // Different gradient for revisions
                : [
                    const Color(0xFF7E57C2),
                    const Color(0xFF5E35B1)
                  ], // Regular units gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: isRevision ? Border.all(color: Colors.white, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: isRevision
                  ? const Color.fromARGB(255, 24, 18, 223)
                  : Colors.black26,
              blurRadius: isRevision ? 15.0 : 10.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isRevision
                    ? Icons.auto_awesome
                    : Icons.menu_book, // Use a different icon for revisions
                size: isRevision ? 60 : 40, // Larger icon for revisions
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                unitTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isRevision
                      ? FontWeight.bold
                      : FontWeight.normal, // Bold text for revisions
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
