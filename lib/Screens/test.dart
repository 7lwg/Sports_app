// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Grid View Demo',
//       home: Scaffold(
//         body: GridView(
//           scrollDirection: Axis.vertical,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 1,
//           ),
//           children: List.generate(10, (index) => Text('Item $index')),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Scroll to the 10th item in the list.
//             final scrollController = ScrollController();
//             scrollController.jumpTo(9);
//           },
//           child: Icon(Icons.arrow_downward),
//         ),
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sport_app_semicolon/Cubits/PlayersCubit/players_cubit.dart';
// import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_teams_cubit.dart';
// import 'package:sport_app_semicolon/Screens/HomeScreen.dart';
// import 'package:sport_app_semicolon/Screens/LoginScreen.dart';
// import 'package:sport_app_semicolon/Screens/PlayersScreen.dart';
// import 'package:sport_app_semicolon/Screens/TeamsScreen.dart';

// class Test extends StatefulWidget {
//   Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = GoogleSignIn();

// var phone;
// var name;

// class _TestState extends State<Test> {
//   @override
//   void initState() {
//     super.initState();
//     Future<String> abc() async {
//       final prefs = await SharedPreferences.getInstance();
//       bool? google_logedin = prefs.getBool('google_logedin') ?? false;

//       bool? phone_logedin = prefs.getBool('phone_logedin') ?? false;
//       String phone_number = prefs.getString('phone_number') ?? "";

//       String google_name = prefs.getString('google_name') ?? "";
//       // name = google_name;
//       // print("*//**//*/**/*/**//**/**//*${google_logedin}");

//       if (google_logedin == true) {
//         name = google_name;
//         phone = null;
//         setState(() {});
//         print("*//**//*/**/*/**//**/**//*${name}");
//         return phone;
//       } else {
//         phone = phone_number;
//         name = null;
//         setState(() {});
//         return name;
//       }
//     }

//     abc();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       width: double.infinity,
//       height: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("${name ?? phone}"),
//           SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//               onPressed: () async {
//                 await signout();
//                 context.read<GetTeamsCubit>().getTeams();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => LoginScreen(),
//                   ),
//                 );
//               },
//               child: Text('logout')),
//           SizedBox(
//             height: 25,
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 context.read<GetTeamsCubit>().getTeams();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => HomeScreen(),
//                   ),
//                 );
//               },
//               child: Text('Home')),
//         ],
//       ),
//     ));
//   }

//   Future<void> signout() async {
//     await _googleSignIn.signOut();
//   }
// }
