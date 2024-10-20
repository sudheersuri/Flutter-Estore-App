import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/product_detail.dart';
import 'package:practice/providers/global_state.dart';
import 'package:shimmer/shimmer.dart';


class Favorites extends ConsumerStatefulWidget {
  const Favorites({super.key});

  @override
  ConsumerState<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends ConsumerState<Favorites> {

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final favorites = ref.watch(favoritesProvider);
    var size = MediaQuery.of(context).size;
    var childAspectRatio = size.width / (size.height * 0.68);
    final favoriteProducts = favorites.length != 0 ? products.where((product) => favorites.contains(product['id'] as int) as bool).toList(): [];
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Favorites', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
          ),
          child: favoriteProducts.isEmpty
              ? Center(child:Text('No favorites', style: TextStyle(fontSize: 20))) : Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: favoriteProducts.isEmpty
                      ? const Center(child: Text('No favorites yet'))
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          gridDelegate:
                           SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 items per row
                            crossAxisSpacing: 0.0, // spacing between columns
                            childAspectRatio: childAspectRatio
                          ),
                          itemCount: favoriteProducts.length,
                          itemBuilder: (context, index) {
                            final product = favoriteProducts[index];
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
                                          child: Container(
                                          height: 185,
                                          color:
                                              Theme.of(context).colorScheme.secondary,
                                          child: CachedNetworkImage(
                                                  imageUrl: imageUrl,
                                                  placeholder: (context, url) => Shimmer.fromColors(
                                                      baseColor: Colors.grey.shade300,
                                                      highlightColor: Colors.grey.shade100,
                                                      child: Container(
                                                        color: Colors.white,
                                                      )
                                                  ),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                      ),
                                                    ),
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
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                            ),
                                            child: IconButton(
                                              icon: favorites.contains(product['id']) ? const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ): const Icon(
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
                          }
                        ),
                      ),
              ],
            ),
          ),
    );
  }
}
