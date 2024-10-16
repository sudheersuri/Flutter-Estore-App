import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/flash_sale_products.dart';
import 'package:practice/pages/product_detail.dart';
import 'package:practice/providers/global_state.dart';
import 'package:practice/widgets/circular_icon_btn.dart';
import 'package:practice/widgets/product_item_loader.dart';
import 'package:flutter/services.dart';

class ProductsList extends ConsumerStatefulWidget {
  const ProductsList({super.key});

  @override
  ConsumerState<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends ConsumerState<ProductsList> {
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    //loading products from local json file
    final String response = await rootBundle.loadString('assets/products.json');
    final products = jsonDecode(response);
    updateState(ref, productsProvider, products['products'].toList());

    //loading products from api
    // const url = 'https://dummyjson.com/products';
    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200) {
    //   updateState(
    //       ref,
    //       productsProvider,
    //       (json.decode(response.body)['products'] as List)
    //           .where((product) => !product['images'][0].contains('placeimg'))
    //           .toList());
    // } else {
    //   throw Exception('Failed to load products');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final favorites = ref.watch(favoritesProvider);
    var size = MediaQuery.of(context).size;
    var childAspectRatio = size.width / (size.height * 0.68);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 16),
            const Text(
              'Popular',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                TextButton(
                  onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FlashSaleProducts(),
                      ),
                    ),
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
        Expanded(
          child: products.isEmpty
              ? const Center(child: ProductItemLoader())
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    // Directly use the image property from the API response
                    String imageUrl = product['images'][0];
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
                                  child: Container(
                                    height: 185,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Image.network(
                                      imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
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
                  }),
        ),
      ],
    );
  }
}
