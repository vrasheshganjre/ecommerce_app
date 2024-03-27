import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/features/shop/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Product image (assuming first image in 'images' list)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: product.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: product.image, // Replace with your image URL
                      fit: BoxFit.cover,
                      height: 200,
                    )
                  : const Placeholder(
                      fallbackHeight: 180.0,
                    ),
            ),
            const SizedBox(height: 8.0),
            // Product name
            Text(
              product.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            // Product description (optional)
            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.0),
            ),
            const SizedBox(height: 8.0),
            // Price with formatting (assuming currency is USD)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add stock indicator if needed
                if (product.stockQuantity > 0)
                  Text(
                    'In Stock (${product.stockQuantity})',
                    style: const TextStyle(fontSize: 12.0, color: Colors.green),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
