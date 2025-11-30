import 'package:flutter/material.dart';

import '/helpers/user_info.dart';
import '/ui/login_page.dart';
import '/ui/produk_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget page;

  @override
  void initState() {
    super.initState();
    page = const CircularProgressIndicator();
    _isLogin();
  }

  Future<void> _isLogin() async {
    final token = await UserInfo().getToken();
    if (mounted) {
      setState(() {
        page = token != null ? const ProdukPage() : const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 8 Malka',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}