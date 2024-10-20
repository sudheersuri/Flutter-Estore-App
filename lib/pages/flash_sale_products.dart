import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/product_detail.dart';
import 'package:practice/providers/global_state.dart';
import 'package:practice/widgets/circular_icon_btn.dart';

class FlashSaleProducts extends ConsumerStatefulWidget {
  const FlashSaleProducts({super.key});

  @override
  ConsumerState<FlashSaleProducts> createState() => _FlashSaleProductsState();
}

class _FlashSaleProductsState extends ConsumerState<FlashSaleProducts> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final favorites = ref.watch(favoritesProvider);
    var size = MediaQuery.of(context).size;
    var childAspectRatio = size.width / (size.height * 0.68);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Flash Sale',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Container(
          color: Colors.white,
          child: products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 0.0, // spacing between columns
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    // Directly use the image property from the API response
                    String imageUrl = product['thumbnail'];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Hero(
                                  tag: product[
                                      'id'], // Unique tag for each product
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      child: Image.network(
                                        imageUrl,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: CircularIconButton(
                                      backgroundColor: Colors.white,
                                      icon: favorites.contains(product['id'])
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              color: Colors.grey,
                                            ),
                                      onPressed: () {
                                        final List<dynamic> newFavorites =
                                            List<dynamic>.from(favorites);
                                        if (favorites.contains(product['id'])) {
                                          newFavorites.remove(product['id']);
                                        } else {
                                          newFavorites.add(product['id']);
                                        }
                                        updateState(
                                          ref,
                                          favoritesProvider,
                                          newFavorites,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            product['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${product['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
    );
  }
}
