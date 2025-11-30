# SS an 
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0efc1211-e693-4fae-99e9-9496425ac23a" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1373f32d-2bb4-4886-8c56-dd56c778900b" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0ddc2981-0e0b-44d8-b930-a096d6870f12" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/38dfdfcc-734d-4a4a-8a21-0d3390544c2a" /> 

# Running 
https://github.com/user-attachments/assets/a200581f-4a55-41c4-9540-14e2ac34ad81



# Penjelasan Pertemuan 10 Tugas 8 (Masih Manual pindah halamannya)
1. Halaman main.dart

File main.dart merupakan pintu masuk utama aplikasi Flutter. Pada file ini terdapat fungsi runApp() yang memulai seluruh aplikasi. Di dalamnya, MaterialApp digunakan untuk menentukan tema dasar aplikasi, judul, serta halaman awal ketika aplikasi dijalankan. Dalam proyek ini, halaman yang pertama kali dipanggil adalah LoginPage, sehingga aplikasi akan langsung menampilkan form login saat dibuka. Dengan struktur ini, aplikasi memastikan bahwa pengguna harus melakukan autentikasi sebelum dapat mengakses fitur lainnya.

Selain itu, main.dart juga bertugas mengatur navigasi umum pada aplikasi. Meskipun tidak banyak konfigurasi routing eksplisit, aplikasi tetap mengandalkan navigasi manual menggunakan Navigator.push dan Navigator.pop dari halaman lain. File ini menjadi pondasi utama dari aplikasi karena seluruh proses pembangunan widget utama dimulai dari sini.

2. Halaman Model (model/login.dart, model/registrasi.dart, model/produk.dart)

Model login.dart menyediakan struktur data sederhana yang berisi dua atribut: username dan password. Model ini digunakan untuk memproses informasi autentikasi yang diberikan oleh pengguna di halaman login. Dengan memisahkan data ke dalam model tersendiri, kode menjadi lebih terorganisir dan memudahkan ekspansi seperti menambah validasi atau memproses data sebelum dikirim ke server.

Model registrasi.dart berfungsi sebagai struktur data untuk menyimpan informasi pendaftaran seperti nama, username, dan password. Halaman registrasi memanfaatkan model ini untuk mengumpulkan data sebelum disimpan atau dikirimkan ke backend. Berkat model ini, proses pengumpulan data menjadi lebih sistematis dan dapat dengan mudah divalidasi.

Model produk.dart mengatur struktur data sebuah produk, termasuk id, nama produk, harga, dan atribut lain yang diperlukan. Model ini digunakan pada halaman produk, halaman form produk, dan halaman detail produk. Dengan membungkus data dalam objek yang terstruktur, seluruh proses CRUD produk dapat dilakukan dengan konsisten di seluruh bagian aplikasi.

3. Halaman product_bloc.dart (Logika Aplikasi)

Halaman ini merupakan pusat logika CRUD aplikasi. BLoC (Business Logic Component) pada file ini bertugas memproses semua operasi terkait produk, seperti menambah produk baru, mengedit produk lama, menampilkan daftar produk, hingga menghapus produk. BLoC berfungsi sebagai jembatan antara UI dan data model sehingga tampilan tidak langsung melakukan pengolahan data.

Dengan adanya BLoC, aplikasi memiliki arsitektur yang lebih bersih karena logika bisnis tidak bercampur dengan kode tampilan. Ketika UI memerlukan data atau melakukan aksi, UI cukup memanggil fungsi yang ada pada BLoC. Sistem ini memudahkan pengembangan lanjutan seperti menambahkan koneksi API atau database lokal tanpa perlu mengubah kode pada halaman UI.

4. Halaman login_page.dart

Halaman login berfungsi sebagai gerbang autentikasi bagi pengguna aplikasi. Pada halaman ini disediakan dua input yaitu username dan password. Ketika pengguna menekan tombol “Login”, halaman ini akan memvalidasi input terlebih dahulu. Jika ada kolom yang kosong atau data tidak sesuai, aplikasi akan menampilkan dialog peringatan melalui WarningDialog.

Selain fungsi login, halaman ini juga menyediakan navigasi menuju halaman pendaftaran bagi pengguna baru melalui tombol "Daftar". Dengan desain ini, halaman login tidak hanya berfungsi sebagai tempat masuk, tetapi juga sebagai titik navigasi awal untuk pengguna yang ingin membuat akun baru. Secara keseluruhan, halaman ini menjadi pusat autentikasi sebelum pengguna dapat mengakses halaman produk.

5. Halaman registrasi_page.dart

Halaman ini memungkinkan pengguna baru mendaftarkan diri ke dalam sistem. Formulir pada halaman ini berisi input nama, username, dan password. Ketika tombol daftar ditekan, aplikasi akan melakukan validasi untuk memastikan bahwa semua kolom telah terisi. Jika validasi gagal, WarningDialog akan muncul untuk memberi tahu pengguna mengenai kesalahan input.

Jika validasi berhasil, data dari form akan dikonversi ke dalam model Registrasi, lalu diteruskan ke proses penyimpanan data. Setelah registrasi berhasil, pengguna diarahkan kembali ke halaman login. Dengan alur seperti ini, halaman registrasi memastikan bahwa proses pembuatan akun dilakukan dengan benar dan aman.

6. Halaman produk_page.dart

Halaman ini menjadi halaman utama setelah pengguna berhasil login. Di halaman ini ditampilkan daftar produk yang diambil dari BLoC. Pengguna dapat melihat daftar produk dalam bentuk list, dan setiap daftar dapat ditekan untuk melihat detailnya. Halaman ini juga dilengkapi tombol tambah (FloatingActionButton) yang jika ditekan akan membawa pengguna ke halaman form untuk menambah produk baru.

Selain fitur melihat dan menambah produk, halaman ini juga memungkinkan pengguna untuk menghapus produk langsung dari daftar. Setelah melakukan operasi seperti menambah atau menghapus produk, halaman ini biasanya akan memperbarui daftar secara otomatis melalui BLoC. Dengan desain ini, produk_page.dart berfungsi sebagai pusat aktivitas CRUD produk dalam aplikasi.

7. Halaman produk_form.dart

Halaman form produk digunakan untuk dua tujuan: menambah produk baru atau mengedit produk yang sudah ada. Di halaman ini terdapat input seperti nama produk dan harga. Bila halaman dipanggil dari "Edit", form akan otomatis terisi data produk yang dipilih sebelumnya. Setelah informasi diisi, tombol "Simpan" akan memproses data melalui BLoC agar produk disimpan atau diperbarui.

Form ini juga dilengkapi validasi sehingga produk tidak dapat disimpan bila terdapat kolom yang masih kosong. Setelah berhasil disimpan, pengguna akan kembali ke halaman daftar produk. Halaman form ini menjadi komponen penting dalam sistem CRUD karena menjadi pintu masuk input data produk.

8. Halaman produk_detail.dart

Halaman detail digunakan untuk menampilkan informasi lengkap dari sebuah produk. Di dalamnya ditampilkan informasi seperti nama produk, harga, serta atribut lainnya secara lebih lengkap dibandingkan daftar produk. Halaman ini juga menyediakan dua tombol utama, yaitu “Edit Produk” dan “Hapus Produk”.

Tombol “Edit” akan mengarahkan pengguna ke halaman produk_form.dart dengan data yang sudah terisi sehingga pengguna dapat langsung memperbarui. Tombol “Hapus” akan menghapus produk melalui BLoC dan mengembalikan pengguna ke daftar produk. Halaman ini membantu pengguna memahami detail suatu Produk dan menentukan aksi lanjutan dengan mudah.

9. Halaman warning_dialog.dart

Halaman ini bukan halaman penuh, melainkan widget dialog yang digunakan di hampir semua halaman. Fungsi utamanya adalah memberikan notifikasi atau peringatan kepada pengguna saat terjadi kesalahan input, kegagalan login, atau kesalahan operasi lainnya.

Dengan membuat dialog dalam file terpisah, aplikasi menjadi lebih konsisten dan mudah dirawat. Alih-alih menulis dialog berulang-ulang di setiap halaman, semua halaman cukup memanggil WarningDialog untuk menampilkan pesan tertentu. Hal ini membuat kode lebih bersih dan mudah dikelola.
