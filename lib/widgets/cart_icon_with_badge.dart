import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'package:practice/providers/global_state.dart';

class Carticonwithbadge extends ConsumerStatefulWidget {
  const Carticonwithbadge({super.key, required this.active});

  final bool active;

  @override
  ConsumerState<Carticonwithbadge> createState() => _CarticonwithbadgeState();
}

class _CarticonwithbadgeState extends ConsumerState<Carticonwithbadge> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartItemsProvider);
    return Stack(
              children: [
                Icon(widget.active ? Icons.shopping_cart : Icons.shopping_cart_outlined),
                Positioned(
                  top: 0,
                  right: 0,
                  child: badges.Badge(
                    badgeAnimation: badges.BadgeAnimation.fade(),
                    position: badges.BadgePosition.topEnd(top: -20, end: -20),
                    badgeContent: Text(
                      cartItems?.length?.toString() ?? '', // Replace '3' with the dynamic cart item count
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      badgeColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.white, width: 2),
                      elevation: 0,
                    ),
                    child: SizedBox.shrink(), // Leave the child empty, badge only
                  ),
                ),
              ],
    );
  }
}