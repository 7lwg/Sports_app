import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sport_app_semicolon/Cubits/FootballCountries/football_countries_cubit.dart';
import 'package:sport_app_semicolon/Data/Models/get_countries_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';
import 'package:sport_app_semicolon/Functions/DrawerClass.dart';
import 'package:sport_app_semicolon/Screens/LeagueScreen.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sport_app_semicolon/Screens/map.dart';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';

class FootballCountriesView extends StatefulWidget {
  @override
  State<FootballCountriesView> createState() => _FootballCountriesViewState();
}

class _FootballCountriesViewState extends State<FootballCountriesView> {
  Position? _currentLocation;
  late bool servicePermeation = false;
  late LocationPermission permission;

  var _currentAdress;
  var _currentName;
  var _country_name;
  var _country_number;
  var _country_index;
  var countries_name = [];

  List<Map<String, dynamic>> fou = [];

  @override
  void initState() {
    super.initState();
  }

  Future<Position> _getCurrentLocation() async {
    servicePermeation = await Geolocator.isLocationServiceEnabled();
    if (!servicePermeation) {
      print("service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> Placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = Placemarks[0];
      setState(() {
        _currentAdress = "${place.administrativeArea}, ${place.country}";
        _country_name = place.country;
        _currentName = place.country;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            color: Colors.black,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          );
        }),
        automaticallyImplyLeading: false,
        title: Text("البلاد يا معلم"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 5.0, // ارتفاع الهامش العمودي
                      horizontal: 16.0, // هامش أفقي
                    ),
                    hintText: _currentAdress ?? 'Please click on the pin',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.black
                            .withOpacity(0.5), // لون الإطار مع الشفافية
                      ),
                    ),
                    // تحكم في شفافية النص التوضيحي
                    hintStyle: TextStyle(
                      color:
                          Colors.black.withOpacity(0.5), // لون النص مع الشفافية
                    ),
                  ),
                  onChanged: (text) {
                    text = "${_currentAdress}";
                  },
                ),
              ),
              IconButton(
                  onPressed: () async {
                    _currentLocation = await _getCurrentLocation();
                    await _getAddressFromCoordinates();
                    print(_currentLocation);
                    for (int i = 0; i < _country_number; i++) {
                      if (_country_name == countries_name[i]) {
                        _country_index = i + 1;
                      }
                    }
                    print('test here');
                    print(_country_index);
                  },
                  icon: Icon(Icons.location_on))
            ],
          ),
          Expanded(
            child: Container(
              // height: 500,
              child:
                  BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
                builder: (context, state) {
                  if (state is FootballCountriesSuccess) {
                    for (int i = 0; i < state.response.result.length; i++) {
                      countries_name
                          .add(state.response.result[i].countryName.toString());
                      // countries_name.add(i);

                      // print(
                      //     "${state.response.result[i].countryName.toString()}, ${i}");
                    }
                    return GridView.builder(
                      // controller: ScrollController(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: state.response.result.length,
                      itemBuilder: (context, index) {
                        _country_number = state.response.result.length;
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () {
                              country_Id =
                                  state.response!.result[index].countryKey;
                              print(country_Id);
                              context
                                  .read<FootballCountriesCubit>()
                                  .getCountries();
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
                                        state.response.result[index]
                                                .countryLogo ??
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/420px-Flag_of_Cuba.svg.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Center(
                                    child: Text(
                                      state.response.result[index]
                                              .countryName ??
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
                      future:
                          context.read<FootballCountriesCubit>().getCountries(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Center(
                            child:
                                Text("An error occurred while loading data."),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class DataSearch extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: Icon(Icons.close))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Text('lpj,d hgfpe');
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
//       builder: (context, state) {
//         if (state is FootballCountriesSuccess) {
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//             ),
//             itemCount: state.response.result.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: GestureDetector(
//                   onTap: () {
//                     country_Id = state.response!.result[index].countryKey;
//                     print(country_Id);
//                     context.read<FootballCountriesCubit>().getCountries();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LeagueScreen(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               state.response.result[index].countryLogo ??
//                                   "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/420px-Flag_of_Cuba.svg.png",
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         state.response.result[index].countryName ??
//                             "countryName",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic,
//                           letterSpacing: 0.5,
//                           wordSpacing: -0.50,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         } else if (state is FootballCountriesError) {
//           return Center(
//             child: Text(state.errorMessage),
//           );
//         } else {
//           return FutureBuilder<void>(
//             future: context.read<FootballCountriesCubit>().getCountries(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else {
//                 return Center(
//                   child: Text("An error occurred while loading data."),
//                 );
//               }
//             },
//           );
//         }
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sport_app_semicolon/Cubits/FootballCountries/football_countries_cubit.dart';
// import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';
// import 'package:sport_app_semicolon/Functions/DrawerClass.dart';
// import 'package:sport_app_semicolon/Screens/LeagueScreen.dart';

// class FootballCountriesView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: myDrawer(),
//       appBar: AppBar(
//         leading: Builder(
//           builder: (context) {
//             return IconButton(
//               color: Colors.black,
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               icon: Icon(Icons.menu),
//             );
//           },
//         ),
//         automaticallyImplyLeading: false,
//         title: Center(child: Text('Football Countries')),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(context: context, delegate: DataSearch());
//             },
//           )
//         ],
//       ),
//       body: BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
//         builder: (context, state) {
//           if (state is FootballCountriesSuccess) {
//             return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//               ),
//               itemCount: state.response.result.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: GestureDetector(
//                     onTap: () {
//                       country_Id = state.response!.result[index].countryKey;
//                       print(country_Id);
//                       context.read<FootballCountriesCubit>().getCountries();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => LeagueScreen(),
//                         ),
//                       );
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 80,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             image: DecorationImage(
//                               image: NetworkImage(
//                                 state.response.result[index].countryLogo ??
//                                     "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/420px-Flag_of_Cuba.svg.png",
//                               ),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Flexible(
//                           child: Center(
//                             child: Text(
//                               state.response.result[index].countryName ??
//                                   "countryName",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontStyle: FontStyle.italic,
//                                 letterSpacing: 0.5,
//                                 wordSpacing: -0.50,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is FootballCountriesError) {
//             return Center(
//               child: Text(state.errorMessage),
//             );
//           } else {
//             return FutureBuilder<void>(
//               future: context.read<FootballCountriesCubit>().getCountries(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   return Center(
//                     child: Text("An error occurred while loading data."),
//                   );
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class DataSearch extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: Icon(Icons.close))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: Icon(Icons.arrow_back));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return Text('lpj,d hgfpe');
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
//       builder: (context, state) {
//         if (state is FootballCountriesSuccess) {
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//             ),
//             itemCount: state.response.result.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: GestureDetector(
//                   onTap: () {
//                     country_Id = state.response!.result[index].countryKey;
//                     print(country_Id);
//                     context.read<FootballCountriesCubit>().getCountries();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LeagueScreen(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 80,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               state.response.result[index].countryLogo ??
//                                   "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/420px-Flag_of_Cuba.svg.png",
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         state.response.result[index].countryName ??
//                             "countryName",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic,
//                           letterSpacing: 0.5,
//                           wordSpacing: -0.50,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         } else if (state is FootballCountriesError) {
//           return Center(
//             child: Text(state.errorMessage),
//           );
//         } else {
//           return FutureBuilder<void>(
//             future: context.read<FootballCountriesCubit>().getCountries(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else {
//                 return Center(
//                   child: Text("An error occurred while loading data."),
//                 );
//               }
//             },
//           );
//         }
//       },
//     );
//   }
// }
