import 'package:ecommerce/core/cubit/user_cubit.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/shop/domain/entities/cart.dart';
import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:ecommerce/features/shop/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const CartView());
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          switch (state) {
            case CartInitial():
              return Container();
            case CartError():
              return const Center(
                child: Text("Unable to fetch your cart"),
              );
            case CartLoaded():
              final cart = state.cart;
              return cart.products.isEmpty
                  ? const Center(
                      child: Text("Your cart is Empty"),
                    )
                  : ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (context, index) {
                        final productList = cart.products.keys.toList();
                        productList.sort((first, second) =>
                            first.name.compareTo(second.name));
                        final product = productList[index];
                        var quantity = cart.products[product]!;
                        return ListTile(
                          leading: Image.network(
                            product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text('Quantity: $quantity'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (quantity > 1) {
                                    quantity--;
                                    context.read<CartBloc>().add(
                                          CartAdd(
                                              uid: user.userId,
                                              productId: product.productId,
                                              quantity: quantity),
                                        );
                                  } else if (quantity == 1) {
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
                                                          productId: product
                                                              .productId),
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
                                  }
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(quantity.toString()),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  quantity++;
                                  context.read<CartBloc>().add(CartAdd(
                                      uid: user.userId,
                                      productId: product.productId,
                                      quantity: quantity));
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            case CartLoading():
              const Center(
                child: CircularProgressIndicator.adaptive(),
              );
              return Container();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state is CartLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : state is CartLoaded
                  ? BottomAppBar(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total: \$${calculateTotalPrice(state.cart).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Checkout'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container();
        },
      ),
    );
  }

  double calculateTotalPrice(Cart cart) {
    double totalPrice = 0;
    for (var cartItem in cart.products.keys) {
      Product product = cartItem;
      int quantity = cart.products[product]!;
      totalPrice += product.price * quantity;
    }
    return totalPrice;
  }
}
