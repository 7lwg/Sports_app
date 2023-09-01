import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_semicolon/Cubits/PlayersCubit/players_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_goals_cubit.dart';
import 'package:sport_app_semicolon/Cubits/TeamsCubit/get_teams_cubit.dart';

class PlayersScreen extends StatelessWidget {
  PlayersScreen({super.key});

  // var search = "Liverpool";
  var search = "";

  var PlyersearchIndex;
  var number;
  var penalty_goals = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * (1 / 10),
        backgroundColor: Colors.red,
        title: Center(child: Text('Players')),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
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
                        BlocBuilder<GetPlayersCubit, GetPlayersState>(
                            builder: (context, state) {
                          if (state is GetPlayersInitial) {
                            return Center(
                              child:
                                  Text('Please press the button to get news'),
                            );
                          } else if (state is GetPlayersLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetPlayersSuccess) {
                            return Expanded(
                                child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  width: 300,
                                  height: 50,
                                  child: TextField(
                                    onChanged: (text) {
                                      // Save the text in the variable
                                      search = text;
                                    },
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.search,
                                            color: const Color.fromARGB(
                                                255, 145, 142, 142),
                                            size: 25),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                                if (search != "" && number != 1)
                                  Text('Invalid Search'),
                                Expanded(
                                    child: ListView.builder(
                                  // itemCount: state.response.result.length,
                                  itemBuilder: (context, index) {
                                    number =
                                        state.playersresponse.result.length;
                                    if (search != "") {
                                      for (int i = 0;
                                          i <
                                              state.playersresponse.result
                                                  .length;
                                          i++) {
                                        if (search ==
                                            state.playersresponse.result[i]
                                                .playerName) {
                                          PlyersearchIndex = i;
                                          number = 1;
                                        }
                                      }
                                    }
                                    if (number == 1) {
                                      return Container(
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
                                            Image.network(state
                                                    .playersresponse
                                                    .result[PlyersearchIndex]
                                                    .playerImage ??
                                                "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              state
                                                      .playersresponse
                                                      .result[PlyersearchIndex]
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
                                      );
                                    } else {
                                      number =
                                          state.playersresponse.result.length;
                                      return Container(
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
                                            Image.network(state
                                                    .playersresponse
                                                    .result[index]
                                                    .playerImage ??
                                                "https://upload.wikimedia.org/wikipedia/ar/f/f7/Fifa-logo.png?20140204004927"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              state.playersresponse
                                                      .result[index].playerName
                                                      .toString() ??
                                                  "",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  // itemCount: 10,
                                  itemCount: number ??
                                      state.playersresponse.result.length,
                                ))
                              ],
                            ));
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
