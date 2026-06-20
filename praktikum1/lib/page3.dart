import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  void showKonfirmasi(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Column(
            children: [
              Icon(
                Icons.calendar_month,
                size: 50,
                color: Colors.blue,
              ),

              SizedBox(height: 10),

              Text(
                "Konfirmasi Janji Temu",
                textAlign: TextAlign.center,
              ),
            ],
          ),

          content: const Text(
            "Ingin menjadwalkan konsultasi dengan dr. Ahmad Hidayat?",
            textAlign: TextAlign.center,
          ),

          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Janji berhasil dibuat"),
                  ),
                );
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget bintang() {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.amber),
        Icon(Icons.star, color: Colors.amber),
        Icon(Icons.star, color: Colors.amber),
        Icon(Icons.star, color: Colors.amber),
        Icon(Icons.star_half, color: Colors.amber),

        SizedBox(width: 10),

        Text(
          "4.5",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto dokter
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "dr. Ahmad Hidayat",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Dokter Anak",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 30,
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "JADWAL PRAKTIK",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Senin - Jumat, 08.00 - 17.00",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 25),

            const Text(
              "BIOGRAFI SINGKAT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Dokter spesialis anak dengan pengalaman lebih dari 10 tahun.",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 25),

            bintang(),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  showKonfirmasi(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                child: const Text(
                  "Buat Janji Temu",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}