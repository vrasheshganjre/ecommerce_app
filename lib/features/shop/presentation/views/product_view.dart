import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/cubit/user_cubit.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:ecommerce/features/shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductView extends StatefulWidget {
  static route(Product product) =>
      MaterialPageRoute(builder: (context) => ProductView(product: product));
  final Product product;
  const ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late UserEntity user;
  @override
  void initState() {
    final state = context.read<UserCubit>().state;
    if (state is UserLoggedIn) {
      user = state.user;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 100,
            ),
            CachedNetworkImage(
              imageUrl: widget.product.image,
              height: 500,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            switch (state) {
              case CartLoading():
                return const SizedBox(
                  width: 20,
                  height: 30,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case CartInitial():
                return Container();
              case CartError():
                return const Center(child: Text("Unable to load cart"));
              case CartLoaded():
                if (state.cart.products.containsKey(widget.product)) {
                  var quantity = state.cart.products[widget.product]!;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FilledButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "This will remove the item from the cart",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    actions: [
                                      FilledButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                                CartRemove(
                                                    uid: user.userId,
                                                    productId: widget
                                                        .product.productId),
                                              );
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Remove"),
                                      ),
                                      FilledButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No"))
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("Remove item")),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            if (quantity > 1)
                              IconButton(
                                onPressed: () {
                                  quantity--;
                                  context.read<CartBloc>().add(
                                        CartAdd(
                                            uid: user.userId,
                                            productId: widget.product.productId,
                                            quantity: quantity),
                                      );
                                },
                                icon: const Icon(Icons.remove),
                              ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(quantity.toString()),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                quantity++;
                                context.read<CartBloc>().add(CartAdd(
                                    uid: user.userId,
                                    productId: widget.product.productId,
                                    quantity: quantity));
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return FilledButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                          CartAdd(
                            uid: user.userId,
                            productId: widget.product.productId,
                            quantity: 1,
                          ),
                        );
                  },
                  child: const Text("Add to cart"),
                );
            }
          },
        ),
      ),
    );
  }
}
