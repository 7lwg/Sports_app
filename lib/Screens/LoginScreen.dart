import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app_semicolon/Cubits/Circular_Indicator_Cubit/circular_indicator_cubit.dart';
import 'package:sport_app_semicolon/Screens/HomeScreen.dart';
import 'package:sport_app_semicolon/Screens/test.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  RegExp phone_number_regex = new RegExp(r"01[0-9]{9}$");

  RegExp otp_code_regex = new RegExp(r"^[0-9]{4}$");

  var otp_code;

  var random_otp;

  var phone_number;

  // RegExp email_regex =
  //     new RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[a-zA-Z0-9.-]+\.com\${0,}");

  // RegExp user_name_regex = new RegExp(r"^([A-Z]+[ a-zA-Z0-9._%+-]{9,})$");

  // RegExp password_regex = new RegExp(
  //     r"(?=^.{9,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$");

  bool? backCase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 1 / ,
                // ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    validator: (value) {
                      // print("Phone number is : ${value}");
                      // phone_number = value.toString();
                      // final prefs =
                      if (phone_number_regex.hasMatch(value!) == false) {
                        return 'Invalid Phone number';
                      } else {
                        phone_number = value;
                        return null;
                      }
                    },
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(Icons.phone,
                            color: Color.fromARGB(255, 145, 142, 142),
                            size: 30),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        hintText: 'Phone number',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),

                  width: MediaQuery.of(context).size.width * 0.8,
                  // height: MediaQuery.of(context).size.height * 0.65,
                  child: TextFormField(
                      onChanged: (text) {
                        otp_code = text;
                      },
                      validator: (value) {
                        if (otp_code_regex.hasMatch(value!) == false) {
                          return 'invalid verification Code';
                        }
                        if (otp_code != random_otp.toString()) {
                          return 'Wrong Code';
                        }
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        prefixIcon: Icon(Icons.verified_user,
                            color: const Color.fromARGB(255, 145, 142, 142),
                            size: 30),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        hintText: 'verification Code',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 1 / 20),
                BlocBuilder<CircularIndicatorCubit, CircularIndicatorState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      child: context.read<CircularIndicatorCubit>().isLoading
                          ? Container(
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    'Please Wait...',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          : Text(
                              'verifying',
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate() &&
                            otp_code == random_otp.toString()) {
                          context.read<CircularIndicatorCubit>().Circular();
                          await Future.delayed(Duration(seconds: 3));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => HomeScreen(),
                            ),
                          );
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('phone_logedin', true);
                          prefs.setBool('google_logedin', false);
                          prefs.setString('phone_number', phone_number);
                          print(phone_number);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          elevation: 10,
                          backgroundColor: Color.fromARGB(255, 21, 131, 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          textStyle: TextStyle(
                            fontSize: 18,
                          )),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    var random = Random();
                    var temp_otp = random.nextInt(8) + 1;
                    random_otp = random.nextInt(1000) + (1000 * temp_otp);
                    // print(random_otp);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('verification Code'),
                          content: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    'You should copy this number and write it in the verification code place'),
                                Text(
                                  random_otp.toString(),
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              child: const Text('Close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black,
                      elevation: 10,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                      )),
                  child: Text(
                    'Generate Verification Code',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FloatingActionButton.extended(
                  onPressed: () async {
                    await signingWithGoogle();
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  icon: SvgPicture.asset(
                    '',
                    height: 32,
                    width: 32,
                  ),
                  label: Text('Sign in with Google'),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> signingWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential userCredential =
        await _auth.signInWithCredential(authCredential);

    User? user = userCredential.user;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('google_logedin', true);
    prefs.setBool('phone_logedin', false);
    print(user?.displayName);
    String? google_name = user!.displayName;
    String? google_photo = user.photoURL;
    String? google_email = user.email;
    String? google_number = user.phoneNumber;
    prefs.setString('google_name', google_name.toString());
    prefs.setString('google_photo', google_photo.toString());
    prefs.setString('google_email', google_email.toString());
    prefs.setString('google_number', google_number.toString());
  }
}



// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sport_app_semicolon/Cubits/Circular_Indicator_Cubit/circular_indicator_cubit.dart';
// import 'package:sport_app_semicolon/Screens/test.dart';

// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   RegExp phone_number_regex = new RegExp(r"01[0-9]{9}$");

//   RegExp otp_code_regex = new RegExp(r"^[0-9]{4}$");

//   bool? backCase;

//   var otp_code;

//   var random_otp;

//   var phone_number;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//           key: _formkey,
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.all(20),
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: TextFormField(
//                     validator: (value) {
//                       print("Phone number is : ${value}");
//                       phone_number = value.toString();
//                       // final prefs =
//                       if (phone_number_regex.hasMatch(value!) == false) {
//                         return 'Invalid Phone number';
//                       } else {
//                         return null;
//                       }
//                     },
//                     textAlign: TextAlign.left,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(15),
//                         prefixIcon: Icon(Icons.phone,
//                             color: Color.fromARGB(255, 145, 142, 142),
//                             size: 30),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         hintText: 'Phone number',
//                         hintStyle: TextStyle(
//                           fontSize: 20,
//                         )),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(left: 20, right: 20),
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: TextFormField(
//                       onChanged: (text) {
//                         otp_code = text;
//                       },
//                       validator: (value) {
//                         if (otp_code_regex.hasMatch(value!) == false) {
//                           return 'invalid verification Code';
//                         }
//                         if (otp_code != random_otp.toString()) {
//                           return 'Wrong Code';
//                         }
//                       },
//                       textAlign: TextAlign.left,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(15),
//                         prefixIcon: Icon(Icons.verified_user,
//                             color: const Color.fromARGB(255, 145, 142, 142),
//                             size: 30),
//                         filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         hintText: 'verification Code',
//                         hintStyle: TextStyle(
//                           fontSize: 20,
//                         ),
//                       )),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 1 / 20),
//                 BlocBuilder<CircularIndicatorCubit, CircularIndicatorState>(
//                   builder: (context, state) {
//                     return ElevatedButton(
//                       child: context.read<CircularIndicatorCubit>().isLoading
//                           ? Container(
//                               width: 200,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 25,
//                                     width: 25,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 25,
//                                   ),
//                                   Text(
//                                     'Please Wait...',
//                                     style: TextStyle(color: Colors.white),
//                                   )
//                                 ],
//                               ),
//                             )
//                           : Text(
//                               'verifying',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                       onPressed: () async {
//                         if (_formkey.currentState!.validate() &&
//                             otp_code == random_otp.toString()) {
//                           context.read<CircularIndicatorCubit>().Circular();
//                           await Future.delayed(Duration(seconds: 3));
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute<void>(
//                               builder: (BuildContext context) => Test(),
//                             ),
//                           );
//                           final prefs = await SharedPreferences.getInstance();
//                           prefs.setBool('phone_logedin', true);
//                           prefs.setString('phone_number', phone_number);
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                           shadowColor: Colors.black,
//                           elevation: 10,
//                           backgroundColor: Color.fromARGB(255, 21, 131, 24),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                           textStyle: TextStyle(
//                             fontSize: 18,
//                           )),
//                     );
//                   },
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     var random = Random();
//                     var temp_otp = random.nextInt(8) + 1;
//                     random_otp = random.nextInt(1000) + (1000 * temp_otp);
//                     print(random_otp);
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: const Text('verification Code'),
//                           content: Container(
//                             height: 100,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Text(
//                                     'You should copy this number and write it in the verification code place'),
//                                 Text(
//                                   random_otp.toString(),
//                                   style: TextStyle(
//                                       fontSize: 35,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           actions: [
//                             ElevatedButton(
//                               child: const Text('Close'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                       shadowColor: Colors.black,
//                       elevation: 10,
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       textStyle: TextStyle(
//                         fontSize: 18,
//                       )),
//                   child: Text(
//                     'Generate Verification Code',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 FloatingActionButton.extended(
//                   onPressed: () async {
//                     await signingWithGoogle();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute<void>(
//                         builder: (context) => Test(),
//                       ),
//                     );
//                   },
//                   icon: SvgPicture.asset(
//                     '',
//                     height: 32,
//                     width: 32,
//                   ),
//                   label: Text('Sign in with Google'),
//                   backgroundColor: Colors.white,
//                 ),
//               ],
//             ),
//           )),
//     );
//   }

//   Future<void> signingWithGoogle() async {
//     GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//     GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount!.authentication;
//     AuthCredential authCredential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken);

//     UserCredential userCredential =
//         await _auth.signInWithCredential(authCredential);

//     User? user = userCredential.user;
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool('google_logedin', true);
//     String? google_name = user!.displayName;
//     String? google_photo = user.photoURL;
//     String? google_email = user.email;
//     String? google_number = user.phoneNumber;
//     prefs.setString('google_name', google_name.toString());
//     prefs.setString('google_photo', google_photo.toString());
//     prefs.setString('google_email', google_email.toString());
//     prefs.setString('google_number', google_number.toString());
//   }
// }
