import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_semicolon/Cubits/Circular_Indicator_Cubit/circular_indicator_cubit.dart';
import 'package:sport_app_semicolon/Cubits/FootballCountries/football_countries_cubit.dart';
import 'package:sport_app_semicolon/Cubits/LeagueCubit/league_cubit.dart';
import 'package:sport_app_semicolon/Cubits/PlayersCubit/players_cubit.dart';
import 'package:sport_app_semicolon/Cubits/SliderCubit/slider_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_goals_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_teams_cubit.dart';
import 'package:sport_app_semicolon/Screens/CountriesScreen.dart';
import 'package:sport_app_semicolon/Screens/LoginScreen.dart';
import 'package:sport_app_semicolon/Screens/OnboardingScreen.dart';
import 'package:sport_app_semicolon/Screens/PlayersScreen.dart';
import 'package:sport_app_semicolon/Screens/SplashScreen.dart';
import 'package:sport_app_semicolon/Screens/test.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(const MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SliderCubit>(
          create: (BuildContext context) => SliderCubit(),
        ),
        BlocProvider<FootballCountriesCubit>(
          create: (BuildContext context) => FootballCountriesCubit(),
        ),
        BlocProvider<LeagueCubit>(
          create: (BuildContext context) => LeagueCubit(),
        ),
        BlocProvider<GetTeamsCubit>(
          create: (BuildContext context) => GetTeamsCubit(),
        ),
        BlocProvider<GetGoalsCubit>(
          create: (BuildContext context) => GetGoalsCubit(),
        ),
        BlocProvider<GetPlayersCubit>(
          create: (BuildContext context) => GetPlayersCubit(),
        ),
        BlocProvider<CircularIndicatorCubit>(
          create: (BuildContext context) => CircularIndicatorCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowMaterialGrid: false,
        home: SplashScreen(),
      ),
    );
  }
}
