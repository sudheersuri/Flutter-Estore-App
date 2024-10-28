import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/providers/global_state.dart';
import 'package:practice/widgets/cart_btn.dart';
import 'package:practice/widgets/circular_icon_btn.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  
  late int selectedImageIndex = 0;
  late bool isImageLoading;
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isImageLoading = true;
    final favorites = ref.watch(favoritesProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: Row(
          children: [
            SizedBox(width: 10),
            CircularIconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: Colors.white,
                icon: Icon(Icons.arrow_back)),
          ],
        ),
        actions: [
          CircularIconButton(
            onPressed: () {
              final List<dynamic> newFavorites = List<dynamic>.from(favorites);
              if (favorites.contains(widget.product['id'])) {
                newFavorites.remove(widget.product['id']);
              } else {
                newFavorites.add(widget.product['id']);
              }
              updateState(
                ref,
                favoritesProvider,
                newFavorites,
              );
            },
            backgroundColor: Colors.white,
            icon: favorites.contains(widget.product['id'])
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                  ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First half: Image centered and takes half of the screen
            Hero(
              tag: widget.product['id'], // Same tag as in list item
              child: ClipRRect(
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  height: MediaQuery.of(context).size.height /
                      2, // Half the screen height
                  width: double.infinity,
                  child: Image.network(
                    widget.product['images'][selectedImageIndex],
                    fit: BoxFit.contain, 
                    loadingBuilder: (context, child, loadingProgress) {
                     if (loadingProgress == null) {
                            return child;
                    }
                    return  Center(child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: Colors.black
                      ),
                    ),);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            widget.product['images'].length > 1 ? productImagesList(): Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product details in the second half
                  Text(
                    widget.product['title'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${widget.product['price'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ), 
                  const SizedBox(height: 10),
                  Text(
                    widget.product['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  // The rest of the product details can go here if necessary
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 75,
        padding: EdgeInsets.all(10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: CartBtn(id: widget.product['id'])),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
              onPressed: () {
               
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size(double.infinity, 75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Center(
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ));
  }

  Container productImagesList() {
    return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            height: 100, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontally
              itemCount: widget.product['images'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImageIndex = index; // Update selected image index when tapped
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(
                        color: selectedImageIndex == index
                            ? Colors.black 
                            : Colors.transparent, 
                        width: 0.4, 
                      ),
                      borderRadius: BorderRadius.circular(10), 
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Optional rounding
                      child: Image.network(
                        widget.product['images'][index], // Thumbnail images
                        fit: BoxFit.cover,
                        width: 100,
                      ),
                    ),
                  ),
                ),
                );
              },
            ),
          );
  }
}

class ProductStats extends StatelessWidget {
  final Icon icon;
  final String text1;
  final String text2;
  const ProductStats({
    super.key,
    required this.icon,
    required this.text1,
    this.text2 = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //add decoration border
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFD1D7D4)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 6),
          Text(text1,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          if (text2.isNotEmpty) ...[
            const SizedBox(width: 6),
            Text(text2),
          ],
        ],
      ),
    );
  }
}
