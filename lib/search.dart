import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  void _searchByName() {
    String query = _searchController.text;
    // Implement search by name logic here
    print('Searching by name: $query');
  }

  Future<void> _searchByImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
      // Implement search by image logic here
      print('Searching by image: ${image.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _searchByName(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchByName,
              child: Text('Search by Name'),
            ),
            SizedBox(height: 16),
            if (_selectedImage != null)
              Column(
                children: [
                  Image.file(
                    File(_selectedImage!.path),
                    height: 200,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ElevatedButton(
              onPressed: _searchByImage,
              child: Text('Search by Image'),
            ),
          ],
        ),
      ),
    );
  }
}
