import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:shopping_app/pages/cart_page.dart';
import 'package:shopping_app/widgets/product_list.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // List of pages to be displayed
  final List<Widget> pages = [
    const ProductList(searchQuery: ''),
    const CartPage(),
  ];

  // Handle page navigation change
  void _handleNavigationChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'),
        actions: [
          AnimSearchBar(
            width: 350,
            textController: _searchController,
            onSuffixTap: () {
              setState(() {
                searchQuery = ''; // Clear the search query
                _searchController.clear();
                pages[0] = ProductList(searchQuery: searchQuery);
              });
            },
            onSubmitted: (String value) {
              setState(() {
                searchQuery = value;
                pages[0] = ProductList(searchQuery: searchQuery);
              });
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
            icon: Icons.home,
            extras: {"label": "Home"},
          ),
          FluidNavBarIcon(
            icon: Icons.shopping_cart,
            extras: {"label": "Cart"},
          ),
        ],
        onChange: _handleNavigationChange,
        style: const FluidNavBarStyle(
          barBackgroundColor: Colors.white,
          iconUnselectedForegroundColor: Colors.black54,
          iconSelectedForegroundColor: Colors.black,
        ),
        scaleFactor: 1.5,
        defaultIndex: currentPage,
      ),
    );
  }
}
