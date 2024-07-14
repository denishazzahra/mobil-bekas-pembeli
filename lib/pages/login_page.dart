import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connection/api_data_source.dart';
import '../widgets/buttons.dart';
import '../utils/colors.dart';
import '../widgets/text_fields.dart';
import '../widgets/texts.dart';
import 'home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

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
                titleText('Login', blackColor, TextAlign.left),
                const SizedBox(height: 5),
                subText('Masukkan informasi akun Anda.', TextAlign.left, true),
                const SizedBox(height: 30),
                textFieldWithLabel(
                  controller: _usernameController,
                  placeholder: 'Username',
                  prefixIcon: const Icon(Icons.person_outline_rounded),
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
                const SizedBox(height: 30),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: blackColor))
                    : blackButton(context, 'Login', login),
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
        subText('Belum punya akun? ', TextAlign.start, true),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpPage(),
              ),
            );
          },
          child: boldDefaultText('Daftar', TextAlign.start),
        )
      ],
    );
  }

  void login() {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text.trim();
    String password = _passwordController.text;
    Map<String, String> body = {
      'username': username,
      'password': password,
    };
    ApiDataSource.login(body).then((data) {
      setState(() {
        _isLoading = false;
        if (data.containsKey('user')) {
          Map<String, dynamic> user = {
            "id": data['user']['id'],
            "nama": data['user']['nama'],
            "username": data['user']['username'],
            "kota": data['user']['kota'],
            "notelepon": data['user']['notelepon']
          };
          setToken(data['user']['token'], user).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login berhasil!')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(data['message'] ?? 'Login gagal, silakan coba lagi!')),
          );
        }
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      });
    });
  }

  Future<void> setToken(String token, Map<String, dynamic> user) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', token);
    await storage.setString('user', jsonEncode(user));
  }
}
