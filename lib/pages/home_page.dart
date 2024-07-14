import 'package:flutter/material.dart';
import 'package:mobil_bekas_pembeli/pages/product_list_page.dart';
import '../widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  String? search;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        currentPageIndex,
        _searchController,
        changePage,
        searchProduct,
      ),
      body: ProductListPage(search: search),
    );
  }

  void changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  void searchProduct(String value) {
    print(value);
  }
}
