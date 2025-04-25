// lib/pages/signup_page.dart

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:rpl/data/db_provider.dart';
import 'package:rpl/data/database.dart';

enum UserType { organization, personal }

extension UserTypeExt on UserType {
  String get title {
    switch (this) {
      case UserType.organization:
        return 'Organization';
      case UserType.personal:
        return 'Personal';
    }
  }

  String get subtitle {
    switch (this) {
      case UserType.organization:
        return '(jika anda ingin menambah event)';
      case UserType.personal:
        return '(jika anda hanya ingin mencari event)';
    }
  }

  String get illustrationAsset {
    switch (this) {
      case UserType.organization:
        return 'assets/illustration_organization.png';
      case UserType.personal:
        return 'assets/illustration_personal.png';
    }
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  UserType? _selectedType;
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false) ||
        _selectedType == null) {
      return;
    }

    final db = DBProvider.db;
    final entry = UsersCompanion(
      username: Value(_usernameCtrl.text.trim()),
      email: Value(_emailCtrl.text.trim()),
      password: Value(_passCtrl.text),
      userType: Value(
          _selectedType == UserType.organization ? 'organization' : 'personal'),
    );

    try {
      await db.into(db.users).insert(entry);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup berhasil!')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      final msg = e.toString().contains('UNIQUE')
          ? 'Username atau email sudah terdaftar'
          : 'Terjadi kesalahan: $e';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedType == null
              ? 'Select Your User Type'
              : 'Sign Up (${_selectedType!.title})',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: _selectedType == null
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _selectedType = null),
              ),
      ),
      body: SafeArea(
        child: _selectedType == null ? _buildSelection() : _buildSignUpForm(),
      ),
    );
  }

  Widget _buildSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: UserType.values.map((type) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: InkWell(
              onTap: () => setState(() => _selectedType = type),
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      type == UserType.organization
                          ? Icons.group_outlined
                          : Icons.person_outline,
                      size: 64,
                      color: Colors.black54,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      type.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(type.subtitle,
                        style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSignUpForm() {
    // pastikan selalu return Widget
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Image.asset(
            _selectedType!.illustrationAsset,
            height: 180,
          ),
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Sign Up',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                // Username
                TextFormField(
                  controller: _usernameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v != null && v.trim().length >= 3)
                      ? null
                      : 'Minimal 3 karakter',
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v?.contains('@') ?? false)
                      ? null
                      : 'Masukkan email valid',
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (v) => (v?.length ?? 0) >= 6
                      ? null
                      : 'Password minimal 6 karakter',
                ),
                const SizedBox(height: 16),

                // Confirm Password
                TextFormField(
                  controller: _confirmCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (v) =>
                      v == _passCtrl.text ? null : 'Password tidak sama',
                ),
                const SizedBox(height: 32),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                      child: const Text(
                        'Login',
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
        ],
      ),
    );
  }
}
