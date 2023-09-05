import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app_semicolon/Screens/HomeScreen.dart';
import 'package:sport_app_semicolon/Screens/LoginScreen.dart';
import 'package:sport_app_semicolon/Screens/test.dart';
import 'OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

bool logedin = false; /////////

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<bool> getPrefs() async {
      final prefs = await SharedPreferences.getInstance();
      bool? showHome = prefs.getBool('showHome') ?? false;

      bool? google_logedin = prefs.getBool('google_logedin') ?? false;

      bool? phone_logedin = prefs.getBool('phone_logedin') ?? false;

      if (google_logedin == true || phone_logedin == true) {
        logedin = true;
      }

      print("/*/**/*//*/***//****/${logedin}");

      // showHome = prefs.getBool('showHome');
      return showHome ?? false;
    }

    Future.delayed(Duration(seconds: 5), () async {
      bool? showHome = await getPrefs();
      Navigator.pushReplacement(
        context,
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(),
        //   ),
        // );
        MaterialPageRoute(
            builder: (context) => showHome!
                ? (logedin! ? HomeScreen() : LoginScreen())
                : OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // الصورة الخلفية
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[850],
          ),

          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.66,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Developed By Semicolon Team",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
