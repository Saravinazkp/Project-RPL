// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:drift/drift.dart'
    hide Column; // ← sembunyikan Column dari Drift
import 'package:rpl/data/db_provider.dart';
import 'package:rpl/data/database.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final db = DBProvider.db;
    final input = _userCtrl.text.trim();
    final password = _passCtrl.text;

    // Query: cari record dimana username == input OR email == input
    final query = db.select(db.users)
      ..where((u) => u.username.equals(input) | u.email.equals(input));
    final user = await query.getSingleOrNull();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User tidak ditemukan')),
      );
      return;
    }

    if (user.password != password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password salah')),
      );
      return;
    }

    // Login sukses → navigasi ke MainScreen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login berhasil!')),
    );
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            // Sekarang ini jelas Column dari Flutter
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ilustrasi di atas
              SizedBox(
                height: mq.height * 0.25,
                child: Image.asset(
                  'assets/illustration_login_personal.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),

              // Judul
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Username or Email
                    TextFormField(
                      controller: _userCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Username or Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          (v != null && v.isNotEmpty) ? null : 'Harus diisi',
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passCtrl,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => setState(() {
                            _obscureText = !_obscureText;
                          }),
                        ),
                      ),
                      obscureText: _obscureText,
                      validator: (v) => (v != null && v.length >= 6)
                          ? null
                          : 'Minimal 6 karakter',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Login Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
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

              // Link ke Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: const Text(
                      'Create Now!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
