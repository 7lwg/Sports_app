import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app_semicolon/Cubits/LeagueCubit/league_cubit.dart';

import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_goals_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_teams_cubit.dart';
import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';
import 'package:sport_app_semicolon/Data/Repository/get_teams_data_repo.dart';
import 'package:sport_app_semicolon/Screens/TeamsScreen.dart';

import 'package:sport_app_semicolon/screens/test.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({super.key});

  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LeagueCubit>().getLeague();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "LEAGUES",
            style: GoogleFonts.lato(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: BlocBuilder<LeagueCubit, LeagueState>(
              builder: (context, state) {
                if (state is LeagueLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LeagueSuccess) {
                  return ListView.builder(
                      itemCount: state.response?.result.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: GestureDetector(
                            onTap: () {
                              league_id =
                                  state.response!.result[index].leagueKey;
                              print(league_id);
                              context.read<GetGoalsCubit>().getGoals();
                              context.read<GetTeamsCubit>().getTeams();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TeamsScreen()));
                            },
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 1 / 3,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: NetworkImage(state.response
                                              ?.result[index].leagueLogo ??
                                          "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927"),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                        );
                      });
                  //Text(
                  //"LEAGUES",
                  // style:
                  //    GoogleFonts.lato(fontSize: 40, color: Colors.white),
                  //),
                } else {
                  return const Center(child: Text("Something wrong happened"));
                }
              },
            ),
          ),
        ));
  }
}
