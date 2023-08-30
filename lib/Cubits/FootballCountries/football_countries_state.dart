part of 'football_countries_cubit.dart';

abstract class FootballCountriesState extends Equatable {
  const FootballCountriesState();

  @override
  List<Object> get props => [];
}

class FootballCountriesInitial extends FootballCountriesState {}

class FootballCountriesLoaded extends FootballCountriesState {
  final List<String> countries;

  FootballCountriesLoaded(this.countries);

  @override
  List<Object> get props => [countries];
}

class FootballCountriesError extends FootballCountriesState {
  final String errorMessage;

  FootballCountriesError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
