// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_semicolon/Cubits/FootballCountries/football_countries_cubit.dart';

class FootballCountriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Football Countries')),
      ),
      body: BlocProvider(
        create: (context) => FootballCountriesCubit()..fetchCountries(),
        child: FootballCountriesView(),
      ),
    );
  }
}

class FootballCountriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
      builder: (context, state) {
        if (state is FootballCountriesLoaded) {
          return ListView.builder(
            itemCount: state.countries.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.countries[index]),
              );
            },
          );
        } else if (state is FootballCountriesError) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
