import 'package:flutter/material.dart';
import 'sign_page.dart';
import 'voice_page.dart';
import 'onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFirstRun = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _checkFirstRun();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (isFirstRun) {
      // Navigate to OnboardingPage and set isFirstRun to false
      prefs.setBool('isFirstRun', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    } else {
      setState(() {
        _isFirstRun = false;
      });
    }
  }

  void _onButtonTap() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstRun) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'SignConnect',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image at the top
                Image.asset(
                  'assets/images/logo2.jpg', // Make sure to add your image in the assets folder
                  height: 150,
                ),
                SizedBox(height: 30),
                ScaleTransition(
                  scale: Tween(begin: 1.0, end: 0.95).animate(
                    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _onButtonTap();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignPage()),
                      );
                    },
                    child: Text('Sign'),
                  ),
                ),
                SizedBox(height: 30),
                ScaleTransition(
                  scale: Tween(begin: 1.0, end: 0.95).animate(
                    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      _onButtonTap();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VoicePage()),
                      );
                    },
                    child: Text('Voice'),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      );
    }
  }
}
