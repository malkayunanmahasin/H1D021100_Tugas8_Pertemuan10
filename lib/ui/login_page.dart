import 'package:flutter/material.dart';
import '/bloc/login_bloc.dart';
import '/helpers/user_info.dart';
import '/ui/produk_page.dart';
import '/ui/registrasi_page.dart';
import '/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late TextEditingController _emailTextboxController;
  late TextEditingController _passwordTextboxController;

  @override
  void initState() {
    super.initState();
    _emailTextboxController = TextEditingController();
    _passwordTextboxController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextboxController.dispose();
    _passwordTextboxController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _emailTextField(),
                _passwordTextField(),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  /// Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }
  /// Membuat Textbox password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }
  /// Membuat Tombol Login
  Widget _buttonLogin() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate() && !_isLoading) {
          _submit();
        }
      },
      child: const Text("Login"),
    );
  }
  Future<void> _submit() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await LoginBloc.login(
        email: _emailTextboxController.text,
        password: _passwordTextboxController.text,
      );

      if (mounted) {
        if (result.code == 200) {
          await UserInfo().setToken(result.token.toString());
          await UserInfo().setUserID(int.parse(result.userID.toString()));

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProdukPage()),
            );
          }
        } else {
          _showErrorDialog();
        }
      }
    } catch (error) {
      debugPrint('Login error: $error');
      if (mounted) {
        _showErrorDialog();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const WarningDialog(
        description: "Login gagal, silahkan coba lagi",
      ),
    );
  }
  /// Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
        child: const Text(
          "Registrasi",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}