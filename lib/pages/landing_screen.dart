import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'admin_login_screen.dart'; // Tambahin ini

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
                  // Background image
                  Positioned.fill(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Hotel in text
                  Positioned(
                    top: isWide
                        ? 200
                        : MediaQuery.of(context).size.height * 0.25,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hotelin',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                          'Your Comfort, Our Priority',
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 0, 87, 121).withOpacity(0.8),
                            fontWeight: FontWeight.w300,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom white panel
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(28)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Ready to explore\nbeyond boundaries?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.teal.shade800,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade700,
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 600),
                                  pageBuilder: (_, __, ___) =>
                                      HomeScreen(),
                                  transitionsBuilder: (_, anim, __, child) {
                                    final offsetAnim = Tween<Offset>(
                                      begin: const Offset(0.0, 1.0),
                                      end: Offset.zero,
                                    ).animate(CurvedAnimation(
                                        parent: anim, curve: Curves.easeOut));

                                    final fadeAnim =
                                        Tween<double>(begin: 0.0, end: 1.0)
                                            .animate(anim);

                                    return SlideTransition(
                                      position: offsetAnim,
                                      child: FadeTransition(
                                          opacity: fadeAnim, child: child),
                                    );
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'Your Stay Starts Here',
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AdminLoginScreen()),
                              );
                            },
                            child: const Text(
                              'Admin Login',
                              style: TextStyle(color: Colors.teal),
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
