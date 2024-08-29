import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome icons
import 'levelsp1.dart';
import 'signin.dart'; // Import the sign-in page

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back button
        backgroundColor: const Color.fromRGBO(124, 77, 255, 1),
        title: const Text(
          'Mr Hossam Aglan',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _confirmLogout(context); // Show confirmation dialog
            },
          ),
        ],
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
              children: [
                const Text(
                  'Select Your Year',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                buildNavigationButton(
                    context, 'Prep One', 'Prep 1', Icons.school),
                buildNavigationButton(
                    context, 'Prep Two', 'Prep 2', Icons.grade),
                buildNavigationButton(
                    context, 'Prep Three', 'Prep 3', Icons.book),
                buildNavigationButton(
                    context, 'Secondary One', 'Secondary 1', Icons.class_),
                buildNavigationButton(context, 'Secondary Two', 'Secondary 2',
                    Icons.emoji_events),
                buildNavigationButton(
                    context, 'Secondary Three', 'Secondary 3', Icons.star),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactUsDialog(context); // Show Contact Us information
        },
        backgroundColor: const Color(0xFF7C4DFF),
        tooltip: 'Contact Us',
        child: const Icon(Icons.contact_phone, size: 28, color: Colors.white),
      ),
    );
  }

  Widget buildNavigationButton(BuildContext context, String buttonText,
      String levelTitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
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
                builder: (context) => LevelsP1(title: levelTitle),
              ),
            );
          },
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(context); // Proceed with logout
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInPage(), // Navigate to the sign-in page
      ),
    );
  }

  // Function to show Contact Us dialog
  void _showContactUsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact Us'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.facebook),
                title: const Text('Facebook Page'),
                onTap: () {
                  _launchFacebook(); // Try to open Facebook app first
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.whatsapp),
                title: const Text('WhatsApp'),
                onTap: () {
                  _launchWhatsApp(); // Open WhatsApp app to chat
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('0100 843 0235'),
                onTap: () {
                  _launchPhone(); // Open phone dialer with the number
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.youtube),
                title: const Text('YouTube Channel'),
                onTap: () {
                  _launchYouTube(); // Open YouTube app or browser to channel
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Function to launch phone dialer
  void _launchPhone() async {
    const phoneNumber = 'tel:01008430235';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      _showErrorDialog('Could not open phone dialer');
    }
  }

  // Function to launch WhatsApp chat
  void _launchWhatsApp() async {
    const whatsappNumber =
        '201008430235'; // Phone number in international format without the '+'
    const whatsappUrl = "https://wa.me/$whatsappNumber?text=Hello";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      _showErrorDialog('Could not open WhatsApp');
    }
  }

  // Function to launch Facebook app or fallback to browser
  void _launchFacebook() async {
    const facebookAppUrl =
        'fb://profile/61562278088545'; // Facebook app deep link
    const fallbackUrl =
        'https://www.facebook.com/profile.php?id=61562278088545&mibextid=LQQJ4d'; // Fallback URL

    try {
      bool launched = await launch(facebookAppUrl,
          forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  // Function to launch YouTube channel
  void _launchYouTube() async {
    const youtubeUrl =
        'https://youtube.com/@hossamajlan3304?si=P46KP0w_QFwxI6v1';
    if (await canLaunch(youtubeUrl)) {
      await launch(youtubeUrl);
    } else {
      _showErrorDialog('Could not open YouTube');
    }
  }

  // Function to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
