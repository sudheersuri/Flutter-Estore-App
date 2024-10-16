import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/pages/product_detail.dart';
import 'package:practice/providers/global_state.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
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
        scrolledUnderElevation: 0,
        title: const Text('Search ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                autofocus: true,
                onChanged: (value) => {
                  setState(() {
                    _searchText = value;
                  })
                },
                decoration: InputDecoration(
                  hintText: "Search products",
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
                                      child: Image.network(
                                        filteredProducts[index]['images'][0],
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(filteredProducts[index]['title']),
                              subtitle: Text(filteredProducts[index]['description'], style: TextStyle(color: Colors.grey, fontSize: 12),
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
