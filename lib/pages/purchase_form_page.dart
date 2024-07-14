import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobil_bekas_pembeli/widgets/buttons.dart';
import 'package:mobil_bekas_pembeli/widgets/text_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Product.dart';
import '../model/user.dart';
import '../utils/colors.dart';
import '../utils/numbers.dart';
import '../widgets/texts.dart';

class PurchasePage extends StatefulWidget {
  final Product product;
  const PurchasePage({super.key, required this.product});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  bool agreeState = false;
  late User user;
  File? fotoKTP;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        title: boldDefaultText('Beli Mobil', TextAlign.center),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                listTitleText('Data Diri', true),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      textFieldWithLabel(
                          controller: _nameController,
                          placeholder: 'Nama Lengkap',
                          readOnly: true),
                      const SizedBox(height: 15),
                      textFieldWithLabel(
                          controller: _phoneController,
                          placeholder: 'Nomor Telepon',
                          readOnly: true),
                      const SizedBox(height: 15),
                      textFieldWithLabel(
                          controller: _cityController,
                          placeholder: 'Kota',
                          readOnly: true),
                      const SizedBox(height: 15),
                      textFieldWithLabel(
                          controller: _photoController,
                          placeholder: 'Foto KTP',
                          readOnly: true,
                          onTap: _pickImage),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                listTitleText('Detail Mobil', true),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smallerSubText('Nama Mobil', TextAlign.left),
                          boldDefaultText(
                            widget.product.name!,
                            TextAlign.left,
                          ),
                          const SizedBox(height: 5),
                          smallerSubText('Tahun', TextAlign.left),
                          boldDefaultText(
                            widget.product.tahun!,
                            TextAlign.left,
                          ),
                          const SizedBox(height: 5),
                          smallerSubText('Penjual', TextAlign.left),
                          boldDefaultText(
                            widget.product.user!['nama']!,
                            TextAlign.left,
                          ),
                          const SizedBox(height: 5),
                          smallerSubText('Harga', TextAlign.left),
                          boldDefaultText(
                            formatCurrency(widget.product.harga!),
                            TextAlign.left,
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: lightGreyColor,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      totalText('DP (30%)'),
                      const SizedBox(width: 30),
                      const Spacer(),
                      totalText(
                          formatCurrency((0.3 * widget.product.harga!).toInt()))
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Checkbox(
                      checkColor: whiteColor,
                      activeColor: blackColor,
                      value: agreeState,
                      onChanged: (bool? value) {
                        setState(() {
                          agreeState = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Saya menyetujui Syarat & Ketentuan dan Kebijakan Privasi.',
                        softWrap: true,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                blackButton(context, 'Beli', () {})
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadData() {
    SharedPreferences.getInstance().then((storage) {
      setState(() {
        user = User.fromJson(jsonDecode(storage.getString('user')!));
        _nameController.text = user.nama!;
        _phoneController.text = user.notelepon!;
        _cityController.text = user.kota!;
        _photoController.text = '--- Unggah foto ---';
      });
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        fotoKTP = File(image.path);
        _photoController.text = image.name;
      });
    }
  }

  void _sendRequest() {
    if (fotoKTP == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Foto KTP tidak boleh kosong!'),
        ),
      );
    } else if (!agreeState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Anda harus menyetujui Syarat & Ketentuan dan Kebijakan Privasi untuk melanjutkan.'),
        ),
      );
    } else {}
  }
}
