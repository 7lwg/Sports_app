import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_semicolon/Cubits/PlayersCubit/players_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_teams_cubit.dart';
import 'package:sport_app_semicolon/Screens/PlayersScreen.dart';
import 'package:sport_app_semicolon/Screens/TeamsScreen.dart';

class Test extends StatefulWidget {
  Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            context.read<GetTeamsCubit>().getTeams();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamsScreen(),
              ),
            );
          },
          child: Text('data')),
    ));
  }
}
