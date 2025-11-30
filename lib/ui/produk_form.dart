import 'package:flutter/material.dart';
import '/bloc/produk_bloc.dart';
import '/model/produk.dart';
import '/ui/produk_page.dart';
import '/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukFormState createState() => _ProdukFormState();
}
class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String _judul;
  late String _tombolSubmit;
  late TextEditingController _kodeProdukTextboxController;
  late TextEditingController _namaProdukTextboxController;
  late TextEditingController _hargaProdukTextboxController;

  @override
  void initState() {
    super.initState();
    _kodeProdukTextboxController = TextEditingController();
    _namaProdukTextboxController = TextEditingController();
    _hargaProdukTextboxController = TextEditingController();
    _initializeForm();
  }

  @override
  void dispose() {
    _kodeProdukTextboxController.dispose();
    _namaProdukTextboxController.dispose();
    _hargaProdukTextboxController.dispose();
    super.dispose();
  }

  void _initializeForm() {
    if (widget.produk != null) {
      setState(() {
        _judul = "UBAH PRODUK";
        _tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk ?? '';
        _namaProdukTextboxController.text = widget.produk!.namaProduk ?? '';
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    } else {
      _judul = "TAMBAH PRODUK";
      _tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  /// Membuat Textbox Kode Produk
  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  /// Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  /// Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }
  /// Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      onPressed: () {
        if (_formKey.currentState!.validate() && !_isLoading) {
          if (widget.produk != null) {
            // kondisi update produk
            _ubah();
          } else {
            // kondisi tambah produk
            _simpan();
          }
        }
      },
      child: Text(_tombolSubmit),
    );
  }

  Future<void> _simpan() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final createProduk = Produk(id: null)
        ..kodeProduk = _kodeProdukTextboxController.text
        ..namaProduk = _namaProdukTextboxController.text
        ..hargaProduk = int.parse(_hargaProdukTextboxController.text);

      await ProdukBloc.addProduk(produk: createProduk);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      }
    } catch (error) {
      debugPrint('Save error: $error');
      if (mounted) {
        _showErrorDialog("Simpan gagal, silahkan coba lagi");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _ubah() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final updateProduk = Produk(id: widget.produk!.id)
        ..kodeProduk = _kodeProdukTextboxController.text
        ..namaProduk = _namaProdukTextboxController.text
        ..hargaProduk = int.parse(_hargaProdukTextboxController.text);

      await ProdukBloc.updateProduk(produk: updateProduk);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      }
    } catch (error) {
      debugPrint('Update error: $error');
      if (mounted) {
        _showErrorDialog("Permintaan ubah data gagal, silahkan coba lagi");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WarningDialog(
        description: message,
      ),
    );
  }
}