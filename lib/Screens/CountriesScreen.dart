import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sport_app_semicolon/Cubits/FootballCountries/football_countries_cubit.dart';
import 'package:sport_app_semicolon/Data/Models/get_countries_model.dart';
import 'package:sport_app_semicolon/Data/Repository/get_League_Repo.dart';
import 'package:sport_app_semicolon/Functions/DrawerClass.dart';
import 'package:sport_app_semicolon/Screens/LeagueScreen.dart';
import 'package:flutter/material.dart';

class FootballCountriesView extends StatefulWidget {
  @override
  State<FootballCountriesView> createState() => _FootballCountriesViewState();
}

class _FootballCountriesViewState extends State<FootballCountriesView> {
  final ScrollController _scrollController = ScrollController();

  double rowHeight = 80;

  Position? _currentLocation;
  late bool servicePermeation = false;
  late LocationPermission permission;

  var _currentAdress;
  var _currentName;
  var _country_name;
  var _country_number;
  var _country_index;
  var countries_name = [];

  final itemController = ItemScrollController();
  final itemListener = ItemPositionsListener.create();

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
        backgroundColor: const Color(0xfff0a307),
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
        title: Text("Countries"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[850],
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1 / 20,
                      child: Text(
                        _currentAdress ?? "please Click on the pin",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                IconButton(
                  onPressed: () async {
                    _currentLocation = await _getCurrentLocation();
                    await _getAddressFromCoordinates();
                    print(_currentLocation);
                    for (int i = 0; i < _country_number; i++) {
                      if (_country_name == countries_name[i]) {
                        _country_index = i;
                      }
                    }
                    print('test here');
                    print(_country_name);

                    double offset = (_country_index / 3) * (rowHeight + 21);

                    _scrollController.animateTo(
                      offset,
                      duration: const Duration(milliseconds: 1 * 1000),
                      curve: Curves.easeInOut,
                    );

                    print(_country_index);
                  },
                  icon: Icon(Icons.location_on),
                  color: Colors.white,
                )
              ],
            ),
            Expanded(
              child: Container(
                child:
                    BlocBuilder<FootballCountriesCubit, FootballCountriesState>(
                  builder: (context, state) {
                    if (state is FootballCountriesSuccess) {
                      for (int i = 0; i < state.response.result.length; i++) {
                        countries_name.add(
                            state.response.result[i].countryName.toString());
                      }
                      return GridView.builder(
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: state.response.result.length,
                        // key: _country_index,
                        itemBuilder: (context, index) {
                          _country_number = state.response.result.length;
                          return Padding(
                            padding: const EdgeInsets.all(0),
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
                                  if (index == _country_index)
                                    Container(
                                      width: 80,
                                      height: rowHeight,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.red, width: 6),
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
                                  if (index != _country_index)
                                    Container(
                                      width: 80,
                                      height: rowHeight,
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
                                          color: Colors.white,
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
                        future: context
                            .read<FootballCountriesCubit>()
                            .getCountries(),
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
      ),
    );
  }
}
