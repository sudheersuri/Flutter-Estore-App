import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/product_detail.dart';
import 'package:practice/providers/global_state.dart';
import 'package:shimmer/shimmer.dart';

class Orders extends ConsumerStatefulWidget {
  const Orders({super.key});

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

final randomDeliveryStatus = ['Delivered on January 1st', 'Shipped', 'Cancelled on Jan 2nd','Pending'];
class _OrdersState extends ConsumerState<Orders> {
   String _searchText = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color secondaryColor = const Color(0xFFF0F1F2);
    final products = ref.watch(productsProvider);
    final filteredProducts = products.length == 0
        ? []
        : products
          .where((product) => product['title'].toLowerCase().contains(_searchText.toLowerCase()) as bool || product['description'].toLowerCase().contains(_searchText.toLowerCase()) as bool)
          .toList();
    return Scaffold(
       appBar: AppBar(
        titleSpacing: 2,
        scrolledUnderElevation: 0,
        title: const Text('Order History', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => {
                  setState(() {
                    _searchText = value;
                  })
                },
                decoration: InputDecoration(
                  hintText: "Search products from orders",
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
              Expanded(
                child: filteredProducts.isEmpty
                    ? Center(
                      child: Text('No results found',
                          style: TextStyle(fontSize: 20)),
                    )
                    : ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                      product: filteredProducts[index]),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: SizedBox(
                                width: 60,
                                child: Hero(
                                  tag: filteredProducts[index]
                                      ['id'], // Unique tag for each product
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      color: secondaryColor,
                                      child: CachedNetworkImage(
                                            imageUrl: filteredProducts[index]['thumbnail'],
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
                                ),
                              ),
                              title: Text(filteredProducts[index]['title']),
                              subtitle: Text(//randomly select delivery status
                                  randomDeliveryStatus[Random().nextInt(randomDeliveryStatus.length)],
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                                  maxLines: 2),
                              trailing: Text('\$${filteredProducts[index]['price']}'),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ));
  }
}