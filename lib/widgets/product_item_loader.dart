import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductItemLoader extends StatelessWidget {
  const ProductItemLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 0.0, // spacing between columns
            childAspectRatio: 0.6, // Adjust to fit the image height
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Theme.of(context).colorScheme.secondary,
                        height: 200,
                        width: double.infinity,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 150,
                    height: 30,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            );
          }),
    );
  }
}
