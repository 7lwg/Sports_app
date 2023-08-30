import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_app_semicolon/Cubits/LeagueCubit/league_cubit.dart';
import 'package:sport_app_semicolon/Screens/test.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({super.key, required String countryName});

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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "LEAGUES",
                      style:
                          GoogleFonts.lato(fontSize: 40, color: Colors.white),
                    ),
                    for (int i = 0; i < state.response!.result.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Test()),
                            );
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 1 / 3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        state.response?.result[i].leagueLogo ??
                                            ""),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Something wrong happened"));
            }
          },
        ),
      ),
    ));
  }
}
