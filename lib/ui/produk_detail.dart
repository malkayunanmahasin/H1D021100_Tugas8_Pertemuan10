import 'package:flutter/material.dart';
import '/bloc/produk_bloc.dart';
import '/model/produk.dart';
import '/ui/produk_form.dart';
import '/ui/produk_page.dart';
import '/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}
class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    final produk = widget.produk;
    if (produk == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Produk'),
        ),
        body: const Center(
          child: Text('Data produk tidak tersedia'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${produk.kodeProduk}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${produk.namaProduk}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${produk.hargaProduk.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(produk: widget.produk),
              ),
            );
          },
          child: const Text("EDIT"),
        ),
        const SizedBox(width: 8.0),
        // Tombol Hapus
        OutlinedButton(
          onPressed: _confirmHapus,
          child: const Text("DELETE"),
        ),
      ],
    );
  }
  void _confirmHapus() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          // Tombol Batal
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          // Tombol Hapus
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              _hapus();
            },
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }

  Future<void> _hapus() async {
    try {
      final produk = widget.produk;
      if (produk == null || produk.id == null) {
        _showErrorDialog("Data produk tidak valid");
        return;
      }

      await ProdukBloc.deleteProduk(id: int.parse(produk.id.toString()));

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      }
    } catch (error) {
      debugPrint('Delete error: $error');
      if (mounted) {
        _showErrorDialog("Hapus gagal, silahkan coba lagi");
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