import 'package:flutter/material.dart';
import 'reservasi_form_screen.dart';
import 'kamar_list_screen.dart';
import 'fasilitas_form_screen.dart'; // Pastikan file ini ada

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;

          return Center(
            child: Container(
              width: isWide ? 420 : double.infinity,
              height: isWide ? 720 : double.infinity,
              decoration: BoxDecoration(
                borderRadius: isWide ? BorderRadius.circular(28) : null,
                boxShadow: isWide
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Center Text
                  Positioned(
                    top: isWide
                        ? 180
                        : MediaQuery.of(context).size.height * 0.25,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Hotelin',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Panel bawah
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(28)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Layanan Kami',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade800,
                              fontFamily: 'montserrat',
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Tombol: Reservasi
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade700,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              minimumSize: Size(double.infinity, 44),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ReservasiFormScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Reservasi Kamar',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Tombol: Daftar Kamar
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade600,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              minimumSize: Size(double.infinity, 44),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const KamarListScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Lihat Kamar',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Tombol: Fasilitas
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade500,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              minimumSize: Size(double.infinity, 44),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FasilitasFormScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Fasilitas Hotel',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
