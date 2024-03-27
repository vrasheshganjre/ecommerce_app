part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStart extends SearchEvent {
  final String query;

  const SearchStart({required this.query});
}
