import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_semicolon/Cubits/FootballCountries/football_countries_cubit.dart';
import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';
import 'package:sport_app_semicolon/Screens/LeagueScreen.dart';
  
class FootballCountriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Football Countries')),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
        builder: (context, state) {
          if (state is FootballCountriesSuccess) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.response.result.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      country_Id = state.response!.result[index].countryKey;
                      print(country_Id);
                      context.read<FootballCountriesCubit>().getCountries();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeagueScreen(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                state.response.result[index].countryLogo ??
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/420px-Flag_of_Cuba.svg.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: Text(
                              state.response.result[index].countryName ??
                                  "countryName",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5,
                                wordSpacing: -0.50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is FootballCountriesError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
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
      ),
    );
  }
}

class DataSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('lpj,d hgfpe');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    return BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
      builder: (context, state) {
        if (state is FootballCountriesSuccess) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: state.response.result.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    country_Id = state.response!.result[index].countryKey;
                    print(country_Id);
                    context.read<FootballCountriesCubit>().getCountries();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeagueScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              state.response.result[index].countryLogo ??
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/420px-Flag_of_Cuba.svg.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        state.response.result[index].countryName ??
                            "countryName",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.5,
                          wordSpacing: -0.50,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is FootballCountriesError) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
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
