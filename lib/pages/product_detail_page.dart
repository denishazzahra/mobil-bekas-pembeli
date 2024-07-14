import 'package:flutter/material.dart';
import 'package:mobil_bekas_pembeli/widgets/buttons.dart';
import 'package:mobil_bekas_pembeli/widgets/texts.dart';

import '../model/Product.dart';
import '../utils/numbers.dart';
import 'purchase_form_page.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late double screenWidth;
  late double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        title: boldDefaultText('Detail Mobil', TextAlign.center),
      ),
      body: SingleChildScrollView(
        child: screenWidth <= 680
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Image.network(
                      widget.product.productImage!,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: dataTable(),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: screenHeight - 102,
                        maxWidth: (screenWidth - 60) / 2,
                      ),
                      child: Image.network(
                        widget.product.productImage!,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(child: dataTable()),
                  ],
                ),
              ),
      ),
    );
  }

  Widget dataTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listTitleText(widget.product.name!, true),
        priceTag(formatCurrency(widget.product.harga!), TextAlign.left, true),
        const SizedBox(height: 15),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: IntrinsicColumnWidth(),
            2: FlexColumnWidth(),
          },
          children: [
            dataRow('Tahun', widget.product.tahun!),
            dataRow('Kota', widget.product.user!['kota']!),
            dataRow('Pemilik', widget.product.user!['nama']!),
          ],
        ),
        const SizedBox(height: 15),
        blackButton(context, 'Beli', buyProduct)
      ],
    );
  }

  TableRow dataRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 2.5, 15, 2.5),
            child: boldDefaultDisableText(label, TextAlign.left),
          ),
        ),
        TableCell(
          child: subText(':', TextAlign.left, true),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 2.5, 0, 2.5),
            child: subText(value, TextAlign.left, true),
          ),
        ),
      ],
    );
  }

  void buyProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PurchasePage(product: widget.product),
      ),
    );
  }
}
