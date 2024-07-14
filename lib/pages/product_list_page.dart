import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mobil_bekas_pembeli/connection/api_data_source.dart';
import 'package:mobil_bekas_pembeli/widgets/texts.dart';

import '../model/Product.dart';
import '../utils/colors.dart';
import '../utils/numbers.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  final String? search;
  const ProductListPage({super.key, this.search});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (products.isEmpty) {
      return Center(
        child: subText('Tidak ada produk.', TextAlign.center, true),
      );
    } else {
      double screenWidth = MediaQuery.of(context).size.width;
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          spacing: 15,
          runSpacing: 15,
          children: products
              .asMap()
              .values
              .map((product) => itemCard(product, screenWidth))
              .toList(),
        ),
      );
    }
  }

  Widget itemCard(Product product, double screenWidth) {
    return Container(
      width: screenWidth <= 320
          ? screenWidth - 30
          : screenWidth <= 680
              ? (screenWidth - 45) / 2
              : screenWidth <= 820
                  ? (screenWidth - 60) / 3
                  : screenWidth <= 1024
                      ? (screenWidth - 75) / 4
                      : (screenWidth - 90) / 5,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: lightGreyColor,
            blurRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  product.productImage!,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          listTitleText(product.name!, false),
                          priceTag(formatCurrency(product.harga!),
                              TextAlign.left, false),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Symbols.location_on,
                                  color: greyTextColor, size: 18),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: subText(product.user!['kota']!,
                                      TextAlign.left, false))
                            ],
                          ),
                          // const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Symbols.person,
                                  color: greyTextColor, size: 18),
                              const SizedBox(width: 5),
                              Expanded(
                                  child: subText(product.user!['nama']!,
                                      TextAlign.left, false))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadProducts() {
    ApiDataSource.getProducts().then((data) {
      setState(() {
        products = (data['products'] as List)
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
      });
    }).catchError((error) {
      SnackBar(content: Text(error.toString()));
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }
}
