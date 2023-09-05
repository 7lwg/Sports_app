import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sport_app_semicolon/Classes/DrawerClass.dart';
import 'package:sport_app_semicolon/Cubits/PlayersCubit/players_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_goals_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_teams_cubit.dart';
import 'package:sport_app_semicolon/Data/Repository/get_players_repo.dart';
import 'package:sport_app_semicolon/Data/Repository/get_teams_data_repo.dart';
import 'package:sport_app_semicolon/Functions/DrawerClass.dart';
import 'package:sport_app_semicolon/Screens/PlayersScreen.dart';

class TeamsScreen extends StatelessWidget {
  TeamsScreen({super.key});

  // var search = "Liverpool";
  var search = "";

  var searchIndex = 0;
  var number;
  var penalty_goals = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Stack(children: [
          Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: MediaQuery.of(context).size.height * (1 / 50),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "Teams",
                      style: TextStyle(fontSize: 18),
                    ),
                    // context.read<GetTeamsCubit>().getTeams(),
                  ),
                  Tab(
                    child: Text(
                      "Top Scorers",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: 300,
                        height: 50,
                        child: TextField(
                          onChanged: (text) {
                            // Save the text in the variable
                            team_name = text;
                            league_id = temp2;
                            context.read<GetGoalsCubit>().getGoals();
                            context.read<GetTeamsCubit>().getTeams();
                          },
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search,
                                  color:
                                      const Color.fromARGB(255, 145, 142, 142),
                                  size: 25),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Search',
                              hintStyle: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                        ),
                      ),
                      BlocBuilder<GetTeamsCubit, GetTeamsState>(
                          builder: (context, state) {
                        if (state is GetTeamsInitial) {
                          return Center(
                            child: Text('Please press the button to get news'),
                          );
                        } else if (state is GetTeamsLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetTeamsSuccess) {
                          return Expanded(
                              child: Column(
                            children: [
                              // if (search != "" && number != 1)
                              //   Text('Invalid Search'),
                              Expanded(
                                  child: ListView.builder(
                                itemBuilder: (context, index) {
                                  number = state.teamsresponse.result.length;
                                  team_id = state.teamsresponse
                                          .result[searchIndex].teamKey ??
                                      10;
                                  print(team_id);

                                  // team_id = state.teamsresponse.result[index]
                                  //         .teamKey ??
                                  //     10;
                                  // print(team_id);
                                  number = state.teamsresponse.result.length;
                                  return InkWell(
                                    onTap: () {
                                      team_id = state.teamsresponse
                                              .result[index].teamKey ??
                                          10;
                                      context
                                          .read<GetPlayersCubit>()
                                          .getPlayers();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlayersScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      margin: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            state.teamsresponse.result[index]
                                                    .teamLogo
                                                    .toString() ??
                                                "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.network(
                                                  "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927");
                                            },
                                            width: 50,
                                            height: 50,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            state.teamsresponse.result[index]
                                                    .teamName ??
                                                "",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                // itemCount: state.response.result.length,
                                itemCount:
                                    number ?? state.teamsresponse.result.length,
                              ))
                            ],
                          ));
                        } else {
                          return Center(
                            child: Text('Something went wrong'),
                          );
                        }
                      })
                    ],
                  ),
                ),
                Container(
                  // color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      BlocBuilder<GetGoalsCubit, GetGoalsState>(
                          builder: (context, state) {
                        if (state is GetGoalsInitial) {
                          return Center(
                            child: Text('Please press the button to get news'),
                          );
                        } else if (state is GetGoalsLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetGoalsSuccess) {
                          return Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                  child: ListView.builder(
                                      itemCount:
                                          state.goalsresponse.result.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 80,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                          margin: EdgeInsets.all(5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                (index + 1).toString(),
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    state
                                                        .goalsresponse
                                                        .result[index]
                                                        .playerName,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Text(
                                                    "penalty goals" +
                                                        state
                                                            .goalsresponse
                                                            .result[index]
                                                            .penaltyGoals
                                                            .toString(),
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                state.goalsresponse
                                                    .result[index].teamName,
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                state.goalsresponse
                                                    .result[index].goals
                                                    .toString(),
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        );
                                      }))
                            ],
                          ));
                        } else {
                          return Center(
                            child: Text('Something went wrong'),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            // top: 55,
            // left: 10,
            child: Builder(builder: (context) {
              return Container(
                margin: EdgeInsets.only(top: 40),
                child: IconButton(
                  color: Colors.black,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                ),
              );
            }),
          )
        ]),
      ),
      drawer: myDrawer(),
    );
  }
}
