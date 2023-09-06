import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app_semicolon/Cubits/LeagueCubit/league_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_goals_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_teams_cubit.dart';
import 'package:sport_app_semicolon/Data/Repository/get_players_repo.dart';
import 'package:sport_app_semicolon/Data/Repository/get_teams_data_repo.dart';
import 'package:sport_app_semicolon/Functions/DrawerClass.dart';
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
        drawer: myDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                color: Colors.black,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu),
              );
            },
          ),
          centerTitle: true,
          title: Text(
            "LEAGUES",
            style: GoogleFonts.lato(color: Colors.black, fontSize: 30),
          ),
          backgroundColor: const Color(0xfff0a307),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[850],
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
                              team_name = "";
                              team_id = "";
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
                              // color: Colors.red,
                              height:
                                  MediaQuery.of(context).size.height * 1 / 3,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(state
                                                    .response
                                                    ?.result[index]
                                                    .leagueLogo ??
                                                "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927"),
                                            fit: BoxFit.contain)),
                                  ),
                                  Center(
                                    child: Text(
                                      "${state.response?.result[index].leagueName}" ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(child: Text("Something wrong happened"));
                }
              },
            ),
          ),
        ));
  }
}
