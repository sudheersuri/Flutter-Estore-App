import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/global_state.dart';

class Allcategories extends ConsumerStatefulWidget {
  const Allcategories({super.key});

  @override
  ConsumerState<Allcategories> createState() => _AllcategoriesState();
}

class _AllcategoriesState extends ConsumerState<Allcategories> {

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Categories',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 0.0, // spacing between columns
                childAspectRatio: 0.67, // Adjust to fit the image height
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                // Directly use the image property from the API response
                String imageUrl = category['image'];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   // MaterialPageRoute(
                          //   //   builder: (context) =>
                          //   //       ProductDetailPage(product: product),
                          //   // ),
                          // );
                        },
                        child: Stack(
                          children: [
                            Hero(
                              tag: category[
                                  'id'], // Unique tag for each product
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  color: Theme.of(context).colorScheme.secondary,
                                  child: Image.network(
                                    imageUrl,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        category['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                );
              }),
    );
  }
}
