import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/widgets/product_card.dart';
import 'package:shopping_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  final String searchQuery;
  const ProductList({super.key, required this.searchQuery});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Adidas',
    'Nike',
    'Bata',
    'Jordan'
  ];
  late String selectedFilter;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];

    // Simulate a network call with a delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProducts = products.where((product) {
      final productTitle = product['title'] as String;
      final filter =
          selectedFilter == 'All' || product['company'] == selectedFilter;
      final searchMatch =
          productTitle.toLowerCase().contains(widget.searchQuery.toLowerCase());
      return filter && searchMatch;
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Material(
                    elevation: selectedFilter == filter ? 5 : 0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedFilter == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 247, 249, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Text(
                              filter,
                              style: TextStyle(
                                color: selectedFilter == filter
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 1080) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.75,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductDetailsPage(
                                        product: product.cast<String, Object>(),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: ProductCard(
                                title: product['title'] as String,
                                price: product['price'] as double,
                                image: product['imageUrl'] as String,
                                backgroundColor: index.isEven
                                    ? const Color.fromRGBO(216, 240, 253, 1)
                                    : const Color.fromRGBO(245, 247, 249, 1),
                              ),
                            );
                          },
                        );
                      } else {
                        // Display products in a list view for smaller screens
                        return ListView.builder(
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProductDetailsPage(
                                        product: product.cast<String, Object>(),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: ProductCard(
                                title: product['title'] as String,
                                price: product['price'] as double,
                                image: product['imageUrl'] as String,
                                backgroundColor: index.isEven
                                    ? const Color.fromRGBO(216, 240, 253, 1)
                                    : const Color.fromRGBO(245, 247, 249, 1),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
