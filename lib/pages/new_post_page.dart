import 'package:flutter/material.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Di aplikasi nyata, gunakan image_picker untuk memilih gambar dan implementasikan logika upload
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('New post functionality not implemented')));
          },
          child: Text('Upload Photo'),
        ),
      ),
    );
  }
}
