import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app_semicolon/Screens/LoginScreen.dart';

class myDrawer extends StatefulWidget {
  myDrawer({super.key});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

var phone;
var name;
var first_name;
var last_name;

class _myDrawerState extends State<myDrawer> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  void initState() {
    super.initState();
    Future<String> abc() async {
      final prefs = await SharedPreferences.getInstance();
      bool? google_logedin = prefs.getBool('google_logedin') ?? false;

      bool? phone_logedin = prefs.getBool('phone_logedin') ?? false;
      String phone_number = prefs.getString('phone_number').toString();
      print("*//**//*/**/*/**//**/**//*${phone_number}");

      String google_name = prefs.getString('google_name') ?? "";
      String google_number = prefs.getString('google_number') ?? "";

      for (int i = 0; i < google_name.length; i++) {
        if (google_name[i] == " ") {
          first_name = google_name.substring(0, i);
          last_name = google_name.substring(i, google_name.length);
          i = google_name.length;
        }
      }
      // name = google_name;
      // print("*//**//*/**/*/**//**/**//*${google_logedin}");

      if (google_logedin == true) {
        name = google_name;
        phone = google_number;
        setState(() {});
        print("*//**//*/**/*/**//**/**//*${name}");
        return phone;
      } else {
        phone = phone_number;
        first_name = null;
        last_name = null;
        print("*//**//*/**/*/**//**/**//*${phone}");
        setState(() {});
        return name;
      }
    }

    abc();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Phone Number :${phone}",
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "First Name :${first_name}",
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Last Name :${last_name}",
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
            ),
            Spacer(),
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 30, right: 20),
              child: Container(
                width: double.infinity,
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    await signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('google_logedin', false);
                    prefs.setBool('phone_logedin', false);
                  },
                  label: Text('Signout'),
                  backgroundColor: Colors.white,
                ),
              ),
            ))
          ],
        )),
      ),
    );
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
