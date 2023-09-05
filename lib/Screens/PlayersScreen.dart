import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

// import 'package:sport_app_semicolon/Classes/DrawerClass.dart';
import 'package:sport_app_semicolon/Cubits/PlayersCubit/players_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_goals_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_teams_cubit.dart';
import 'package:sport_app_semicolon/Data/Repository/get_players_repo.dart';
import 'package:sport_app_semicolon/Functions/DrawerClass.dart';

// ignore: must_be_immutable
class PlayersScreen extends StatelessWidget {
  PlayersScreen({super.key});

  // var search = "Liverpool";

  static String search_plyer = "";

  var PlyersearchIndex;

  var number;

  var penalty_goals = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            color: Colors.white,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          );
        }),
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * (1 / 20),
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text('Players'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              width: 300,
              height: 50,
              child: TextField(
                onChanged: (text) {
                  // Save the text in the variable
                  player_name = text;
                  team_id = temp;
                  context.read<GetPlayersCubit>().getPlayers();
                  // search = "Mo";
                },
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search,
                        color: const Color.fromARGB(255, 145, 142, 142),
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
            BlocBuilder<GetPlayersCubit, GetPlayersState>(
                builder: (context, state) {
              if (state is GetPlayersInitial) {
                return Center(
                  child: Text('Please press the button to get news'),
                );
              } else if (state is GetPlayersLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetPlayersSuccess) {
                return Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        // if (search != "" && number != 1)
                        // Text('Invalid Search'),
                        Expanded(
                            child: ListView.builder(
                          // itemCount: state.response.result.length,
                          itemBuilder: (context, index) {
                            // search = 'mo';
                            // search_name = search;
                            // number = state.playersresponse.result.length;
                            // if (search != "") {
                            //   for (int i = 0;
                            //       i <
                            //           state.playersresponse.result
                            //               .length;
                            //       i++) {
                            //     if (search ==
                            //         state.playersresponse.result[i]
                            //             .playerName) {
                            //       PlyersearchIndex = i;
                            //       number = 1;
                            //     }
                            //   }
                            // }
                            // if (number == 1) {
                            //   return Container(
                            //     width: 40,
                            //     height: 40,
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       border: Border.all(
                            //         color: Colors.black,
                            //         width: 2,
                            //       ),
                            //     ),
                            //     margin: EdgeInsets.all(5),
                            //     child: Row(
                            //       children: [
                            //         Image.network(state
                            //                 .playersresponse
                            //                 .result[PlyersearchIndex]
                            //                 .playerImage ??
                            //             "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927"),
                            //         SizedBox(
                            //           width: 10,
                            //         ),
                            //         Text(
                            //           state
                            //                   .playersresponse
                            //                   .result[PlyersearchIndex]
                            //                   .playerName
                            //                   .toString() ??
                            //               "",
                            //           style: TextStyle(fontSize: 20),
                            //         ),
                            //         SizedBox(
                            //           width: 10,
                            //         ),
                            //       ],
                            //     ),
                            //   );
                            // } else {
                            // number = state.playersresponse.result.length;
                            return InkWell(
                              onTap: () {
                                // context.read<GetPlayersCubit>().getPlayers();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Player\'s info',
                                          style: GoogleFonts.lato(),
                                        ),
                                        content: SingleChildScrollView(
                                          child: BlocBuilder<GetPlayersCubit,
                                              GetPlayersState>(
                                            builder: (context, state) {
                                              if (state is GetPlayersLoading) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (state
                                                  is GetPlayersSuccess) {
                                                return Column(
                                                  children: [
                                                    Text(
                                                      "Name : ${state.playersresponse!.result[index].playerName ?? ""}",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Number : ${state.playersresponse!.result[index].playerNumber ?? ""}",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Country : ${state.playersresponse!.result[index].playerCountry ?? ""}",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Center(
                                                        child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              1 /
                                                              3,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(state
                                                                      .playersresponse!
                                                                      .result[
                                                                          index]
                                                                      .playerImage ??
                                                                  'https://cdn.britannica.com/51/190751-050-147B93F7/soccer-ball-goal.jpg'),
                                                              fit:
                                                                  BoxFit.fill)),
                                                    )),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Matches Played : ${state.playersresponse!.result[index].playerMatchPlayed ?? ""}",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Age : ${state.playersresponse.result[index].playerAge} ",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Yellow Cards Num : ${state.playersresponse!.result[index].playerYellowCards ?? ""}",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Red Cards Num : ${state.playersresponse!.result[index].playerRedCards ?? ""}",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Goals : ${state.playersresponse!.result[index].playerGoals ?? ""}",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Assists : ${state.playersresponse!.result[index].playerAssists ?? ""}",
                                                      style: GoogleFonts.lato(
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Share.share(
                                                              "Name : ${state.playersresponse!.result[index].playerName ?? ""}\nNumber : ${state.playersresponse!.result[index].playerNumber ?? ""}");
                                                        },
                                                        child: Text(
                                                            "Share Player"))
                                                  ],
                                                );
                                              } else {
                                                return const Center(
                                                    child: Text(
                                                        "Something wrong happened"));
                                              }
                                            },
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      );
                                    });
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
                                      state.playersresponse.result[index]
                                              .playerImage ??
                                          "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.network(
                                            "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927");
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      state.playersresponse.result[index]
                                              .playerName
                                              .toString() ??
                                          "",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          // },
                          // itemCount: 10,
                          itemCount:
                              number ?? state.playersresponse.result.length,
                        ))
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text('Somethinge went wrone'),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
