import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:practice/providers/global_state.dart';
import 'package:practice/widgets/cart_items_list.dart';
import 'package:practice/widgets/circular_icon_btn.dart';

class Cart extends ConsumerStatefulWidget {
  const Cart({super.key});

  @override
  ConsumerState<Cart> createState() => _CartState();
}

class _CartState extends ConsumerState<Cart> {

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final cartItems = ref.watch(cartItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        actions: [
          CircularIconButton(
            onPressed: () {
              // Logic to clear cart
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.more_horiz),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: !cartItems.isEmpty
            ? Column(
                children: [
                  // Delivery address section
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Wrap(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.grey),
                            SizedBox(width: 8),
                            Text(
                              '92 High Street, London',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Icon(Icons.chevron_right_outlined,
                            color: Colors.grey, size: 20),
                      ],
                    ),
                  ),
                  Container(
                      height: 20.0,
                      padding: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Container(
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      )),
                  // Select All and items list
                  CartItemsList(),
                  // Checkout button at the bottom
                  !cartItems.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: \$${_calculateTotal(products, cartItems)}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                            ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 12),
                                  backgroundColor: Theme.of(context)
                                      .primaryColor,
                                       // Light green color from the image
                                ),
                                onPressed: () {
                                  // Logic for checkout
                                },
                                child: const Text('Checkout',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              )
            : Center(child: Text('Empty cart', style: TextStyle(fontSize: 20))),
      ),
    );
  }

  double _calculateTotal(List<dynamic> products, List<dynamic> cartItemIds) {
    double total = 0.0;
    if (cartItemIds.isEmpty) {
      return total;
    }
    for (var c in cartItemIds) {
      final product = products.firstWhere((p) => p['id'] == c.id);
      total += product['price'] * c.qty;
    }
    //round to 2
    return double.parse(total.toStringAsFixed(2));
  }
}
