import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/cubit/user_cubit.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:ecommerce/features/shop/presentation/bloc/shop_view/shop_view_bloc.dart';
import 'package:ecommerce/features/shop/presentation/views/cart_view.dart';
import 'package:ecommerce/features/shop/presentation/views/category_view.dart';
import 'package:ecommerce/features/shop/presentation/views/product_view.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  late UserEntity user;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();

  @override
  void initState() {
    final state = context.read<UserCubit>().state;

    if (state is UserLoggedIn) {
      context.read<ShopViewBloc>().add(ShopViewLoad());
      context.read<CartBloc>().add(CartLoad(uid: state.user.userId));
      user = state.user;
    }

    super.initState();
  }

  List<String> categories = [
    "Men's Clothing",
    "Jewelery",
    "Electronics",
    "Women's Clothing",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                user.avatarurl,
              ),
            )),
        toolbarHeight: 80,
        title: SizedBox(
          height: 50,
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              context.read<SearchBloc>().add(
                    SearchStart(query: value.trim()),
                  );
              setState(() {});
            },
            decoration: InputDecoration(
                hintText: "Search here",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0.2),
                border: const OutlineInputBorder(
                  gapPadding: 0.1,
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                filled: true,
                suffixIcon: IconButton(
                    onPressed: () {
                      searchController.text = "";
                      setState(() {});
                    },
                    icon: const Icon(Icons.close))),
          ),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    Navigator.push(context, CartView.route());
                  },
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag,
                        size: 40,
                      ),
                      if (state is CartLoaded)
                        Align(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 10,
                            foregroundColor: Colors.white,
                            child: Text(state.cart.products.length.toString()),
                          ),
                        )
                    ],
                  ));
            },
          )
        ],
      ),
      body: searchController.text.trim().isNotEmpty
          ? BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
              switch (state) {
                case SearchInitial():
                  return Container();
                case SearchLoading():
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                case SearchSuccess():
                  return state.products.isEmpty
                      ? const Center(
                          child: Text("No results found"),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: false,
                          childAspectRatio: 1 / 2,
                          children: state.products
                              .map((product) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context, ProductView.route(product));
                                  },
                                  child: ProductCard(product: product)))
                              .toList(),
                        );
                case SearchError():
                  return Center(
                    child: Text(state.error),
                  );
              }
            })
          : RefreshIndicator.adaptive(
              onRefresh: () async => Future.delayed(
                const Duration(seconds: 1),
                () => context.read<ShopViewBloc>().add(ShopViewLoad()),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Shop by category",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  CategoryView.route(categories[index]));
                            },
                            child: Chip(
                              label: Text(categories[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Explore products",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  BlocConsumer<ShopViewBloc, ShopViewState>(
                    builder: (context, state) {
                      switch (state) {
                        case ShopViewInitial():
                          return Container();
                        case ShopViewLoading():
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        case ShopViewFailure():
                          return const Text("Failed to recieve data");
                        case ShopViewSuccess():
                          return Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: false,
                              childAspectRatio: 1 / 2,
                              children: state.products
                                  .map((product) => InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            ProductView.route(product));
                                      },
                                      child: ProductCard(product: product)))
                                  .toList(),
                            ),
                          );
                      }
                    },
                    listener: (context, state) {},
                  ),
                ],
              ),
            ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          CachedNetworkImageProvider(user.avatarurl),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: FilledButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthSignOut());
                    },
                    child: const Text("Log out")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
