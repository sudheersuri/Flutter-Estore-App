import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItemLoader extends StatelessWidget {
  const CategoryItemLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    width: double.infinity,
                    height: 42,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 8),
                        Container(
                          width: 150,
                          height: 30,
                          color: Colors.grey.shade300, // Fake title placeholder
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 20,
                              color: Colors
                                  .grey.shade300, // Fake button placeholder
                            ),
                            const SizedBox(width: 8),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  Colors.grey.shade300, // Fake icon placeholder
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6, // Arbitrary number of skeleton items
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors
                                      .grey.shade300, // Circle placeholder
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 60,
                                height: 14,
                                color: Colors.grey.shade300, // Text placeholder
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
        );
  }
}