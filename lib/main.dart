import 'package:firebase_core/firebase_core.dart';
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
import 'package:sport_app_semicolon/Screens/PlayersScreen.dart';
import 'package:sport_app_semicolon/Screens/SplashScreen.dart';
import 'package:sport_app_semicolon/Screens/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
