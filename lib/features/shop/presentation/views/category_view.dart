import 'package:ecommerce/features/shop/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:ecommerce/features/shop/presentation/views/product_view.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryView extends StatefulWidget {
  final String category;
  static route(String category) => MaterialPageRoute(
        builder: (context) => CategoryView(category: category),
      );
  const CategoryView({super.key, required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    context
        .read<CategoryBloc>()
        .add(CategoryLoad(categoryId: widget.category.toLowerCase()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        switch (state) {
          case CategoryInitial():
            return Container();
          case CategoryLoading():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case CategorySuccess():
            return GridView.count(
              crossAxisCount: 2,
              shrinkWrap: false,
              childAspectRatio: 1 / 2,
              children: state.products
                  .map((product) => InkWell(
                      onTap: () {
                        Navigator.push(context, ProductView.route(product));
                      },
                      child: ProductCard(product: product)))
                  .toList(),
            );
          case CategoryError():
            return const Center(
              child: Text("Cannot retrieve data"),
            );
        }
      }),
    );
  }
}
