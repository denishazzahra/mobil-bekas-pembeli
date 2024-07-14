import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../connection/api_data_source.dart';
import '../utils/colors.dart';
import '../widgets/buttons.dart';
import '../widgets/text_fields.dart';
import '../widgets/texts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool isRegisterSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                titleText('Daftar', blackColor, TextAlign.left),
                const SizedBox(height: 5),
                subText('Buat akun untuk melanjutkan.', TextAlign.left, true),
                const SizedBox(height: 30),
                textFieldWithLabel(
                  controller: _fullNameController,
                  placeholder: 'Nama Lengkap',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                ),
                const SizedBox(height: 15),
                textFieldWithLabel(
                  controller: _usernameController,
                  placeholder: 'Username',
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                ),
                const SizedBox(height: 15),
                textFieldWithLabel(
                  controller: _phoneController,
                  placeholder: 'Nomor Telepon',
                  prefixIcon: const Icon(Icons.numbers_rounded),
                ),
                const SizedBox(height: 15),
                textFieldWithLabel(
                  controller: _cityController,
                  placeholder: 'Kota',
                  prefixIcon: const Icon(Symbols.location_city, fill: 0),
                ),
                const SizedBox(height: 15),
                textFieldWithLabel(
                  controller: _passwordController,
                  placeholder: 'Kata Sandi',
                  isObscure: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: greyTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                textFieldWithLabel(
                  controller: _confirmPasswordController,
                  placeholder: 'Ulangi Kata Sandi',
                  isObscure: _obscureConfirmPassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    child: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: greyTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: blackColor))
                    : blackButton(context, 'Daftar', signUp),
                const SizedBox(height: 15),
                _signupButton(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signupButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        subText('Sudah punya akun? ', TextAlign.start, true),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: boldDefaultText('Login', TextAlign.start),
        )
      ],
    );
  }

  bool validatePassword(String password) {
    // Minimum length of 8 characters
    if (password.length < 8) {
      return false;
    }
    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return false;
    }
    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return false;
    }
    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return false;
    }
    // Check for at least one special character
    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(password)) {
      return false;
    }
    // All checks passed, the password is strong
    return true;
  }

  bool validateFullName(String fullName) {
    // Minimum length of 4 and maximum of 50 characters
    if (fullName.length < 4 || fullName.length > 50) {
      return false;
    }
    // Check if the fullName has only alphabet or space
    if (!RegExp(r'^([a-zA-Z]+[\s]?)+$').hasMatch(fullName)) {
      return false;
    }
    // All checks passed, the fullName is valid
    return true;
  }

  bool validateUsername(String username) {
    if (username.length < 4 || username.length > 20) {
      return false;
    }
    // Check for at least one letter
    if (!RegExp(r'[a-zA-Z]').hasMatch(username)) {
      return false;
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return false;
    }
    return true;
  }

  bool validatePhone(String phone) {
    if (!RegExp(r'^\d{8,15}$').hasMatch(phone)) {
      return false;
    }
    return true;
  }

  void signUp() {
    String text = '';
    String fullName = _fullNameController.text.trim();
    String username = _usernameController.text.trim();
    String phone = _phoneController.text.trim();
    String city = _cityController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    if (!validateFullName(fullName)) {
      text =
          'Nama lengkap harus terdiri dari 4-50 karakter alfabet atau spasi, tanpa spasi ganda.';
      isRegisterSuccess = false;
    } else if (!validateUsername(username)) {
      text =
          'Username harus terdiri dari 4-20 karakter alfabet, angka, atau underscore.';
      isRegisterSuccess = false;
    } else if (!validatePhone(phone)) {
      text = 'Nomor telepon harus terdiri dari 8-15 karakter angka.';
      isRegisterSuccess = false;
    } else if (!validatePassword(password)) {
      text =
          'Kata sandi minimal terdiri dari 8 karakter yang terdiri dari huruf besar, huruf kecil, angka, dan simbol.';
      isRegisterSuccess = false;
    } else if (password != confirmPassword) {
      text = 'Kata sandi tidak sama!';
      isRegisterSuccess = false;
    } else {
      Map<String, dynamic> body = {
        'nama': fullName,
        'username': username,
        'notelepon': phone,
        'kota': city,
        'password': password,
        'roleId': 2
      };
      setState(() {
        _isLoading = true;
      });
      ApiDataSource.signup(body).then((data) {
        setState(() {
          if (data['status'] == 'Success') {
            isRegisterSuccess = true;
            text = 'Daftar berhasil!';
            Navigator.pop(context);
          } else {
            isRegisterSuccess = false;
            text = data['message'];
          }
          _isLoading = false;
          SnackBar snackbar = SnackBar(content: Text(text));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      }).catchError((error) {
        setState(() {
          _isLoading = false;
          isRegisterSuccess = false;
          text = 'An error occurred: $error';
          SnackBar snackbar = SnackBar(content: Text(text));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
      });
    }
    if (!_isLoading) {
      SnackBar snackbar = SnackBar(content: Text(text));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
