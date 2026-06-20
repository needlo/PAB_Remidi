import 'package:flutter/material.dart';
import 'package:praktikum1/page3.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  Widget menuDokter(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Page3(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "HealthHub",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Banner
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1584982751601-97dcc096659c',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(20),
              child: const Text(
                "HealthHub:\nYour health partner",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Menu dokter
            menuDokter(
              context,
              Icons.medical_services,
              "Dokter Umum",
            ),

            menuDokter(
              context,
              Icons.medical_information,
              "Dokter Gigi",
            ),

            menuDokter(
              context,
              Icons.child_care,
              "Dokter Anak",
            ),

            menuDokter(
              context,
              Icons.pets,
              "Dokter Hewan",
            ),
          ],
        ),
      ),
    );
  }
}