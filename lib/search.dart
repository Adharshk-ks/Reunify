import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:reunifyfiire/info.dart'; // Import InfoPage

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  List<Map<String, dynamic>> _similarImages = [];
  bool _isSearching = false; // Track whether searching/loading

  Future<void> _search() async {
    setState(() {
      _isSearching = true; // Start searching/loading
    });

    if (_selectedImage != null || _searchController.text.isNotEmpty) {
      String query = _searchController.text.trim();

      String? base64Image;
      if (_selectedImage != null) {
        List<int> imageBytes = await _selectedImage!.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      print('Query: $query');
      print('Base64 Image: $base64Image');

      await _performSearch(query, base64Image);

      setState(() {
        _isSearching = false; // Finish searching/loading
      });
    } else {
      setState(() {
        _isSearching = false; // Finish searching/loading (if no search criteria)
      });
    }
  }

  Future<void> _performSearch(String query, String? base64Image) async {
    final Map<String, dynamic> requestData = {
      'query': query,
      'image': base64Image,
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.34:5000/search'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      List<dynamic> similarImages = jsonDecode(response.body);
      setState(() {
        _similarImages = similarImages.cast<Map<String, dynamic>>();
      });
    } else {
      print('Failed to search: ${response.statusCode}');
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
          onPressed: _search,
        ),
      ),
      onSubmitted: (_) => _search(),
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: _isSearching
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator while searching
            )
          : _similarImages.isNotEmpty
              ? ListView.builder(
                  itemCount: _similarImages.length,
                  itemBuilder: (context, index) {
                    // Extract fields safely
                    String productName = _similarImages[index]['name'] ?? '';
                    String location = _similarImages[index]['location'] ?? '';
                    String contact = _similarImages[index]['contact'] ?? '';
                    String imageUrl = _similarImages[index]['imageUrl'] ?? '';
                    String userEmail = _similarImages[index]['userEmail'] ?? '';
                    double similarityScore = _similarImages[index]['similarity_score'] ?? 0.0;
                    bool isListed = _similarImages[index]['isListed'] ?? false;
                    String description = _similarImages[index]['description'] ?? '';
                    String time = _similarImages[index]['time'] ?? '';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoPage(
                              productName: productName,
                              location: location,
                              contact: contact,
                              imageUrl: imageUrl,
                              userEmail: userEmail,
                              description: description,
                              isListing: isListed,
                              time: time,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 26),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text('Location: $location'),
                                    Text('Contact: $contact'),
                                    Text(
                                      isListed ? 'FOUND' : 'LOST',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isListed ? Colors.green : Colors.red,
                                      ),
                                    ),
                                    Text('Similarity Score: ${similarityScore.toStringAsFixed(2)}'), // Display similarity score
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No similar images found.'),
                ),
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
              onPressed: () async {
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    _selectedImage = image;
                  });
                  _search();
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text('Search by Image'),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildSearchResults(),
          ],
        ),
      ),
    );
  }
}
