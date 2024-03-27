part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryLoad extends CategoryEvent {
  final String categoryId;

  const CategoryLoad({required this.categoryId});
}
