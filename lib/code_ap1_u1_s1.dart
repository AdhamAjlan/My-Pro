import 'package:flutter/material.dart';
import 'package:helloworld/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:async'; // Import for Timer
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding
import 'U1S1A.dart';
import 'mainscreen.dart'; // Ensure this path is correct
// Redirect to SignInPagimport 'package:webview_flutter/webview_flutter.dart';import 'package:webview_flutter/webview_flutter.dart';e if no token

class CodeAP1U1S1 extends StatefulWidget {
  final String title; // Dynamic title
  final String videoUrl; // Dynamic video URL

  const CodeAP1U1S1({required this.title, required this.videoUrl, Key? key})
      : super(key: key);

  @override
  _CodeAP1U1S1State createState() => _CodeAP1U1S1State();
}

class _CodeAP1U1S1State extends State<CodeAP1U1S1> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = true;
  bool _passwordValid = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _checkStoredPassword();
  }

  Future<void> _checkStoredPassword() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedDate = prefs.getString('session_1_date_${widget.title}');

    if (storedDate != null) {
      try {
        // Parse the stored date and handle exceptions
        DateTime expiryDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').parse(storedDate);
        if (expiryDate.isAfter(DateTime.now())) {
          _passwordValid = true;
          _startTimer(); // Start the timer for auto lock
        }
      } catch (e) {
        print("Error parsing storedDate: $e");
        await prefs.remove('session_1_date_${widget.title}');
      }
    }

    setState(() {
      _isLoading = false;
    });

    if (_passwordValid) {
      _navigateToVideo(); // Automatically navigate if password is already valid
    }
  }

  Future<void> _checkPassword(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Retrieve the stored token
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        // If no token is found, notify the user and redirect to the login page
        _showAlert(context, 'No user is logged in. Please log in first.');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const SignInPage()), // Redirect to SignInPage
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final response = await http.post(
        Uri.parse(
            'https://educational-platform-woad.vercel.app/api/v1/videos/prep-one/o-level/1/1/activate'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Add the token to the request headers
        },
        body: jsonEncode(<String, String>{
          'code': _controller.text, // Sending the access code
        }),
      );

      if (response.statusCode == 200) {
        String expiryDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(
          DateTime.now().add(const Duration(minutes: 1)), // Valid for one minute
        );
        await prefs.setString('session_1_date_${widget.title}', expiryDate);

        setState(() {
          _passwordValid = true; // Mark the session as unlocked
        });

        _startTimer(); // Start the timer for auto lock after one minute
        _navigateToVideo(); // Navigate directly to video
      } else {
        final errorResponse = jsonDecode(response.body);
        _showAlert(context, errorResponse['message'] ?? 'Incorrect Code');
      }
    } catch (e) {
      _showAlert(context, 'An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer(const Duration(minutes: 1), () {
      setState(() {
        _passwordValid = false; // Lock the session after one minute
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Mainscreen()));
    });
  }

  void _navigateToVideo() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VideoP1U1S1A(
          title: widget.title, // Pass the dynamic title
          videoUrl: widget.videoUrl, // Pass the dynamic video URL
        ),
      ),
    );
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sorry'),
          content: Text(message),
          actions: <Widget>[
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

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Mainscreen()));
          },
        ),
        title: Text(
          widget.title, // Dynamic title
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildPasswordInputScreen(context),
    );
  }

  Widget _buildPasswordInputScreen(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurpleAccent,
            Colors.purpleAccent,
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Enter Access Code',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Code',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _checkPassword(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Colors.deepPurpleAccent,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
