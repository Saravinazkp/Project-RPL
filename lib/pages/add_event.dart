import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart'
    hide Column; // ← sembunyikan Column dari Drift
import 'package:rpl/data/db_provider.dart';
import 'package:rpl/data/database.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({Key? key}) : super(key: key);

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  int _step = 0;
  File? _pamfletFile;
  final _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _dateCtrl.dispose();
    _locationCtrl.dispose();
    _contactCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickPamflet(ImageSource src) async {
    final picked = await _picker.pickImage(source: src);
    if (picked != null) {
      setState(() => _pamfletFile = File(picked.path));
    }
  }

  Future<void> _onAction() async {
    if (_step == 0) {
      if (_pamfletFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih pamflet terlebih dahulu')),
        );
        return;
      }
      setState(() => _step = 1);
    } else {
      if (!(_formKey.currentState?.validate() ?? false)) return;

      // Buat companion dan simpan ke database
      final companion = EventsCompanion(
        pamphlet: Value(_pamfletFile!.path),
        title: Value(_titleCtrl.text.trim()),
        description: Value(_descCtrl.text.trim()),
        date: Value(DateTime.parse(_dateCtrl.text)),
        location: Value(_locationCtrl.text.trim()),
        contact: Value(_contactCtrl.text.trim()),
      );

      await DBProvider.db.into(DBProvider.db.events).insert(companion);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event berhasil ditambahkan')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Events'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_step == 1) {
              setState(() => _step = 0);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: _onAction,
            child: Text(
              _step == 0 ? 'Next' : 'Post',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Pamflet preview
          Container(
            color: Colors.black,
            height: 200,
            width: double.infinity,
            child: _pamfletFile != null
                ? Image.file(_pamfletFile!, fit: BoxFit.cover)
                : const Center(
                    child: Text(
                      'No Pamflet Selected',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _step == 0 ? _buildStep0() : _buildStep1(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep0() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Pamflet', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickPamflet(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Gallery'),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: () => _pickPamflet(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep1() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _titleCtrl,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v != null && v.trim().isNotEmpty) ? null : 'Harus diisi',
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descCtrl,
            decoration: const InputDecoration(
              labelText: 'Event Information',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
            validator: (v) =>
                (v != null && v.trim().isNotEmpty) ? null : 'Harus diisi',
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _dateCtrl,
            decoration: const InputDecoration(
              labelText: 'Date (YYYY-MM-DD)',
              border: OutlineInputBorder(),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Harus diisi';
              try {
                DateTime.parse(v);
                return null;
              } catch (_) {
                return 'Format salah';
              }
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _locationCtrl,
            decoration: const InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v != null && v.trim().isNotEmpty) ? null : 'Harus diisi',
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _contactCtrl,
            decoration: const InputDecoration(
              labelText: 'Contact',
              border: OutlineInputBorder(),
            ),
            validator: (v) =>
                (v != null && v.trim().isNotEmpty) ? null : 'Harus diisi',
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
