import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left decorative shape
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/top_shape.png',
              width: mq.width * 0.4,
            ),
          ),

          // Bottom-right decorative shape
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/bottom_shape.png',
              width: mq.width * 0.5,
            ),
          ),

          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      'Welcome\nTo CodeConnect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Illustration
                    Image.asset(
                      'assets/illustration.png',
                      width: mq.width * 0.7,
                    ),

                    const SizedBox(height: 48),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: navigasi ke halaman Login
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: navigasi ke halaman Sign Up
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Or Continue With
                    const Text(
                      'Or Continue With',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Social Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            // TODO: Facebook auth
                          },
                          icon: const FaIcon(FontAwesomeIcons.facebookF),
                        ),
                        const SizedBox(width: 24),
                        IconButton(
                          onPressed: () {
                            // TODO: Google auth
                          },
                          icon: const FaIcon(FontAwesomeIcons.google),
                        ),
                        const SizedBox(width: 24),
                        IconButton(
                          onPressed: () {
                            // TODO: Twitter auth
                          },
                          icon: const FaIcon(FontAwesomeIcons.twitter),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
