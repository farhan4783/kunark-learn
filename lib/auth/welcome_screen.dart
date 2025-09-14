// lib/auth/welcome_screen.dart - NEW MODERN DESIGN

import 'package:flutter/material.dart';
import 'package:rural_learning_app/auth/signin_screen.dart';
import 'package:rural_learning_app/auth/signup_screen.dart';
import 'package:rural_learning_app/main.dart'; // To use AppColors

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- Background Gradient and Blobs ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A86FF), Color(0xFF5A9BFF)], // Custom blue gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Soft circular "blobs" for decoration
          _buildBlob(color: Colors.white.withOpacity(0.15), top: -100, left: -100, size: 200),
          _buildBlob(color: Colors.white.withOpacity(0.15), top: 150, right: -150, size: 300),
          _buildBlob(color: Colors.white.withOpacity(0.1), bottom: -50, left: -50, size: 150),
          _buildBlob(color: Colors.white.withOpacity(0.1), bottom: 100, right: 50, size: 80),

          // --- Main Content ---
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Spacer to push content to the center
                const Spacer(flex: 2),

                // --- Title and Subtitle Text ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      const Text(
                        'Konark Learn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Play Learn Achieve More',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Get Started',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacer to push buttons to the bottom
                const Spacer(flex: 3),

                // --- Sign In and Sign Up Buttons ---
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (e) => const SignInScreen())),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          // The transparent color makes the gradient background visible
                          color: Colors.transparent,
                          child: const Text(
                            'Sign in',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (e) => const SignUpScreen())),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            // This creates the unique curved corner
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Sign up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primary, // Using our app's main color
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the decorative blobs
  Widget _buildBlob({
    required Color color,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}