import 'package:flutter/material.dart';
import '/bloc/registrasi_bloc.dart';
import '/widget/success_dialog.dart';
import '/widget/warning_dialog.dart';
class RegistrasiPage extends StatefulWidget {
const RegistrasiPage({Key? key}) : super(key: key);

@override
_RegistrasiPageState createState() => _RegistrasiPageState();
}
class _RegistrasiPageState extends State<RegistrasiPage> {
final _formKey = GlobalKey<FormState>();
bool _isLoading = false;
final _namaTextboxController = TextEditingController();
final _emailTextboxController = TextEditingController();
final _passwordTextboxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrasi"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _namaTextField(),
                _emailTextField(),
                _passwordTextField(),
                _passwordKonfirmasiTextField(),
                _buttonRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Membuat Textbox Nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama"),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value == null || value.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
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
        const pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        final regex = RegExp(pattern);
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
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
        if (value == null || value.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  /// Membuat textbox Konfirmasi Password
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Konfirmasi Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  /// Membuat Tombol Registrasi
  Widget _buttonRegistrasi() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate() && !_isLoading) {
          _submit();
        }
      },
      child: const Text("Registrasi"),
    );
  }

  Future<void> _submit() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await RegistrasiBloc.registrasi(
        nama: _namaTextboxController.text,
        email: _emailTextboxController.text,
        password: _passwordTextboxController.text,
      );

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
            description: "Registrasi berhasil, silahkan login",
            okClick: () {
              Navigator.pop(context);
            },
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Registrasi gagal, silahkan coba lagi",
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}