import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import package url_launcher

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portofolio Saya',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String whatsappNumber =
      '6285314696763'; // Ganti dengan nomor WhatsApp kamu

  // Fungsi untuk membuka WhatsApp
  void openWhatsApp(String name, String email, String message) async {
    // Encode pesan yang akan dikirim ke WhatsApp
    final String encodedMessage = Uri.encodeComponent(
        'Halo saya $name.\nEmail: $email\n\nPesan: $message');

    final Uri url =
        Uri.parse('https://wa.me/$whatsappNumber?text=$encodedMessage');

    // Cek apakah bisa membuka URL
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak bisa membuka WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    final namaController = TextEditingController();
    final emailController = TextEditingController();
    final pesanController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portofolio Saya'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Foto Profil dan Tentang
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Navigasi untuk membuka foto profil dalam layar penuh
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FullScreenImagePage(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      'assets/images/profil.jpeg'), // Gambar placeholder
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Bravi Ambat',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'IT Technical Support & Developer',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Saya adalah lulusan Sistem Informasi dari Universitas Klabat, berpengalaman di bidang IT Support, jaringan, troubleshooting, dan pengembangan aplikasi sederhana.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Pengalaman
          const Text('Pengalaman',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          pengalamanItem(
              'IT Technical Support (Magang)',
              'PT Angkasa Pura Indonesia (Mei 27-November 03 (2024)',
              'Menangani troubleshooting jaringan, printer, hardware.'),
          pengalamanItem(
              'IT Technical Support (Fulltime)',
              'PT Angkasa Pura Support (2025-Sekarang)',
              'Memantau aliran data, memberikan dukungan teknis kepada user & membuat laporan performance sistem perbulan.'),
          pengalamanItem(
              'Freelance Teknisi di CV Winwin Solutions Away',
              '2024 - sekarang',
              'Pernah melakukan instalasi jaringan starlink (bagian penarikan, creamping LAN & FO), .'),

          const SizedBox(height: 30),

          // Portofolio
          const Text('Proyek yang pernah dibuat',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          portofolioItem(
              'Aplikasi Pemesanan tempat penggilingan padi di daerah Langowan',
              'assets/images/developer.jpeg'),
          portofolioItem('UI/UX UMKM', 'assets/images/jaringan.jpeg'),
          portofolioItem('Analisis Infrastruktur IT Menggunakan Cobit 2019',
              'assets/images/cobit.jpeg'),

          const SizedBox(height: 30),

          // Kontak
          const Text('Kontak',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            controller: namaController,
            decoration: const InputDecoration(labelText: 'Nama'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: pesanController,
            decoration: const InputDecoration(labelText: 'Pesan'),
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              openWhatsApp(namaController.text, emailController.text,
                  pesanController.text);
            },
            child: const Text('Kirim ke WhatsApp'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Widget untuk menampilkan pengalaman
  Widget pengalamanItem(String title, String subtitle, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            const SizedBox(height: 5),
            Text(description),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan proyek
  Widget portofolioItem(String title, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  const FullScreenImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foto Profil'),
        centerTitle: true,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset('assets/images/profil.jpeg'), // Gambar profil
        ),
      ),
    );
  }
}
