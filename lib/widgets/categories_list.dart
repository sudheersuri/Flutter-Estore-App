import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/all_categories.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:practice/providers/global_state.dart';
import 'package:practice/widgets/category_item_loader.dart';

class CategoriesList extends ConsumerStatefulWidget {
  const CategoriesList({super.key});

  @override
  ConsumerState<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends ConsumerState<CategoriesList> {
  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {

    //loading categories from local json file
    final String response =
        await rootBundle.loadString('assets/categories.json');
    final categories = jsonDecode(response);
    updateState(ref, categoriesProvider,
        categories.where((c) => !c['image'].contains('placeimg.com')).toList());
    
    //loading categories from api
    // final response =
    //     await http.get(Uri.parse('YOUR_API_URL'));
    // if (response.statusCode == 200) {
    //   final categories = jsonDecode(response.body);
    //   updateState(
    //       ref,
    //       categoriesProvider,
    //       categories
    //           .where((c) => !c['image'].contains('placeimg.com'))
    //           .toList());
    // } else {
    //   throw Exception('Failed to load categories');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    return categories.isEmpty
        ? Center(
            child: const CategoryItemLoader()
          )
        : Column(
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
                    const Text(
                      'Shop by Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Allcategories(),
                              ),
                            );
                          },
                          child: const Text(
                            'See all',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image.network(
                                  category['image'],
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['name'],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
