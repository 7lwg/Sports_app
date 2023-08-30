import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:equatable/equatable.dart';

part 'football_countries_state.dart';

class FootballCountriesCubit extends Cubit<FootballCountriesState> {
  FootballCountriesCubit() : super(FootballCountriesInitial());

  Future<void> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse('https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=!_your_account_APIkey_!'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        emit(FootballCountriesLoaded(data.cast<String>()));
      } else {
        emit(FootballCountriesError('Failed to fetch countries'));
      }
    } catch (e) {
      emit(FootballCountriesError('An error occurred'));
    }
  }
}
