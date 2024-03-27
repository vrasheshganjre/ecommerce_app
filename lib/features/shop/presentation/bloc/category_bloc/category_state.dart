part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {
  final List<Product> products;

  const CategorySuccess({required this.products});
}

final class CategoryError extends CategoryState {
  final String error;

  const CategoryError({required this.error});
}
