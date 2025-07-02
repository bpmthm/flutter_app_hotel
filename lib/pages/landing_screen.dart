import 'package:flutter/material.dart';
import 'home_screen.dart'; // Ganti dengan screen tujuan lo

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
                    top: isWide ? 200 : MediaQuery.of(context).size.height * 0.25,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hotel',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'in',
                            style: TextStyle(
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
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
                        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
                              shape: StadiumBorder(),
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: Duration(milliseconds: 600),
                                  pageBuilder: (_, __, ___) => HomeScreen(),
                                  transitionsBuilder: (_, anim, __, child) {
                                    final offsetAnim = Tween<Offset>(
                                      begin: Offset(0.0, 1.0),
                                      end: Offset.zero,
                                    ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut));

                                    final fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(anim);

                                    return SlideTransition(
                                      position: offsetAnim,
                                      child: FadeTransition(opacity: fadeAnim, child: child),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Your Stay Starts Here',
                              style: TextStyle(fontSize: 14, color: Colors.white),
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
