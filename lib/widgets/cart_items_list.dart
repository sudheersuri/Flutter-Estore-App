import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/models/cart.dart';
import 'package:practice/providers/global_state.dart';
import 'package:practice/widgets/circular_icon_btn.dart';
import 'package:shimmer/shimmer.dart';

class CartItemsList extends ConsumerStatefulWidget {
  const CartItemsList({super.key});

  @override
  ConsumerState<CartItemsList> createState() => _CartItemsListState();
}

class _CartItemsListState extends ConsumerState<CartItemsList> {
  
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartItemsProvider);
    final products = ref.watch(productsProvider);
    return   Expanded(
                      child: ListView(
                    children: [
                      // Displaying cart items
                      ...cartItems.map((c) {
                        final product =
                            products.firstWhere((p) => p['id'] == c.id);
                        return ListTile(
                          leading:  SizedBox(
                            width: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Theme.of(context).colorScheme.secondary,
                                child: CachedNetworkImage(
                                              imageUrl: product['thumbnail'],
                                              placeholder: (context, url) => Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.grey.shade100,
                                                  child: Container(
                                                    color: Colors.white,
                                                  )
                                              ),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                              imageBuilder: (context, imageProvider) => Container(
                                                width: 60,
                                                height: 200,
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
                                                          title: Text(product['title']),
                                                          subtitle:
                                                              Text('\$${product['price'].toStringAsFixed(2)}'),
                                                          trailing: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              CircularIconButton(
                                                                backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                                                                icon: const Icon(Icons.remove),
                                                                iconSize: 12,
                                                                onPressed: () {
                                if (cartItems.length == 0) {
                                  return;
                                }
                                final List<CartItem> newCartItems =
                                    List<CartItem>.from(cartItems);
                                //reduce by 1 if qty is greater than 1
                                if (c.qty > 1) {
                                  newCartItems
                                      .firstWhere(
                                          (element) => element.id == c.id)
                                      .qty -= 1;
                                } else {
                                  newCartItems.removeWhere(
                                      (element) => element.id == c.id);
                                }
                                updateState(
                                    ref, cartItemsProvider, newCartItems);
                                                                },
                                                              ),
                                                              Padding(
                                                                padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                                                                child: Text(c.qty.toString()),
                                                              ),
                                                              CircularIconButton(
                                                                backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                                                                icon: const Icon(Icons.add),
                                                                iconSize: 12,
                                                                onPressed: () {
                                if (cartItems.length == 0) {
                                  return;
                                }
                                final List<CartItem> newCartItems =
                                    List<CartItem>.from(cartItems);
                                newCartItems
                                    .firstWhere(
                                        (element) => element.id == c.id)
                                    .qty += 1;
                                updateState(
                                    ref, cartItemsProvider, newCartItems);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                      }).toList(),
                    ],
                  ));
  }
}