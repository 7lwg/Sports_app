// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_semicolon/Cubits/FootballCountries/football_countries_cubit.dart';

class FootballCountriesView extends StatelessWidget {
  String country_name = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
      builder: (context, state) {
        if (state is FootballCountriesSuccess) {
          return ListView.builder(
            itemCount: state.response.result.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        country_name = state.response.result[index].countryName;
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                                state.response.result[index].countryLogo ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      (state.response.result[index].countryName ??
                          "countryName"),
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is FootballCountriesError) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          // Show loading indicator using FutureBuilder
          return FutureBuilder<void>(
            future: context.read<FootballCountriesCubit>().getCountries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text("An error occurred while loading data."),
                );
              }
            },
          );
        }
      },
    );
  }
}
