import 'package:ecommerce/features/shop/data/models/cart_model.dart';
import 'package:ecommerce/features/shop/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ShopRemoteDatasource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsbyCategory(String category);
  Future<List<ProductModel>> searchProducts(String query);
  Future<ProductModel> getProductById(int productId);
  Future<void> addToCart(int productId, String uid, int quantity);
  Future<void> removeFromCart(int productId, String uid);
  Future<CartModel> getCart(String uid);
}

class ShopRemoteDatasourceImpl implements ShopRemoteDatasource {
  final SupabaseClient client;

  ShopRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final res = await client.from("products").select();
      return res.map((e) => ProductModel.fromMap(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ProductModel>> getProductsbyCategory(String category) async {
    try {
      final res =
          await client.from("products").select().eq("category", category);
      return res.map((e) => ProductModel.fromMap(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final res =
          await client.from("products").select().or('name.ilike.%$query%');
      return res.map((e) => ProductModel.fromMap(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> addToCart(int productId, String uid, int quantity) async {
    try {
      final res = await client
          .from("cart")
          .select()
          .eq("user_id", uid)
          .eq("product_id", productId);
      if (res.isNotEmpty) {
        await client
            .from("cart")
            .update(
              {
                "quantity": quantity,
              },
            )
            .eq('user_id', uid)
            .eq("product_id", productId);
      } else {
        await client.from("cart").insert(
          {
            "user_id": uid,
            "product_id": productId,
            "quantity": quantity,
          },
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<CartModel> getCart(String uid) async {
    try {
      final res = await client.from("cart").select().eq("user_id", uid);
      if (res.isNotEmpty) {
        CartModel cart = CartModel(userId: uid, products: {});
        for (var item in res) {
          cart.products[await getProductById(item["product_id"])] =
              item["quantity"];
        }
        return cart;
      }
      return CartModel(userId: uid, products: {});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> removeFromCart(int productId, String uid) async {
    try {
      await client
          .from("cart")
          .delete()
          .eq("user_id", uid)
          .eq("product_id", productId);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<ProductModel> getProductById(int productId) async {
    try {
      final res =
          await client.from("products").select().eq("product_id", productId);
      if (res.isNotEmpty) return ProductModel.fromMap(res.first);
      throw 'Item not found';
    } catch (e) {
      throw e.toString();
    }
  }
}
