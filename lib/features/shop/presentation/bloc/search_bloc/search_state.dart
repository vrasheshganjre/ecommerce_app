part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<Product> products;

  const SearchSuccess({required this.products});
}

final class SearchError extends SearchState {
  final String error;

  const SearchError({required this.error});
}
