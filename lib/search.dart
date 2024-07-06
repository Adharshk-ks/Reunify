import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  void _searchByName(String query) {
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
      _searchByName('Image search: ${image.path}');
    }
  }

  void _removeSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Search by Name/Description',
        border: OutlineInputBorder(),
        prefixIcon: _selectedImage != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.file(File(_selectedImage!.path), fit: BoxFit.cover),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: _removeSelectedImage,
                    ),
                  ],
                ),
              )
            : null,
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            String query = _searchController.text;
            _searchByName(query);
          },
        ),
      ),
      onSubmitted: (_) {
        String query = _searchController.text;
        _searchByName(query);
      },
    );
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
            _buildSearchBar(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchByImage,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Search by Image'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
