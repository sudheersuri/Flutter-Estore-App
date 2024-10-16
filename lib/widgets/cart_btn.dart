import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/models/cart.dart';
import 'package:practice/providers/global_state.dart';

class CartBtn extends ConsumerStatefulWidget {
  const CartBtn({
    super.key,
    required this.id,
  });

  final int id;

  @override
  ConsumerState<CartBtn> createState() => _CartBtnState();
}

class _CartBtnState extends ConsumerState<CartBtn> {

  @override
  Widget build(BuildContext context) {
    
    final cartItems = ref.watch(cartItemsProvider);
    //check whether the product id is in the cartItems {id:1, qty:1} list matching id 
    final cartItemStatusText = cartItems.map((e) => e.id).contains(widget.id) ? 'Remove from Cart' : 'Add to Cart';
    return  ElevatedButton(
              onPressed: () {
                final List<CartItem> newCartItems = List<CartItem>.from(cartItems);
                if (cartItemStatusText == 'Add to Cart') {
                  newCartItems.add(CartItem(id: widget.id, qty: 1));
                } else {
                  newCartItems.removeWhere((element) => element.id == widget.id);
                }
                updateState(ref, cartItemsProvider, newCartItems);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                minimumSize: Size(double.infinity, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                cartItemStatusText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
          );
  }
}