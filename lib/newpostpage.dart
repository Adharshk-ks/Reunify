import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universal_io/io.dart' as uio;

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  uio.File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  bool _isListing = true; // New variable for toggle state
  String? _imageUrl;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = uio.File(pickedFile.path);
      });
    }
  }

  Future<void> _submitPost() async {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final location = _locationController.text;
    final contact = _contactController.text;
    final time = _timeController.text;

    if (_image == null || name.isEmpty || description.isEmpty || location.isEmpty || contact.isEmpty || time.isEmpty) {
      // Handle empty fields or image (e.g., show a Snackbar or Dialog)
      return;
    }

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('post_images/${DateTime.now().millisecondsSinceEpoch}');
      final uploadTask = await storageRef.putFile(_image!);
      final imageUrl = await uploadTask.ref.getDownloadURL();
      setState(() {
        _imageUrl = imageUrl;
      });

      // Save post data to Firestore
      await FirebaseFirestore.instance.collection('posts').add({
        'name': name,
        'description': description,
        'location': location,
        'contact': contact,
        'time': time,
        'imageUrl': imageUrl,
        'isListing': _isListing, // Save the toggle state
        'timestamp': Timestamp.now(),
        'userEmail': user?.email,
      });

      // Navigate back or show success message
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
      // Handle error (e.g., show a Snackbar or Dialog)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: uio.Platform.isAndroid || uio.Platform.isIOS
                              ? Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                )
                              : _imageUrl != null
                                  ? Image.network(
                                      _imageUrl!,
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                        )
                      : Center(
                          child: Icon(
                            Icons.add,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('List'),
                  Switch(
                    value: !_isListing,
                    onChanged: (value) {
                      setState(() {
                        _isListing = !value;
                      });
                    },
                  ),
                  Text('Claim'),
                ],
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: _nameController,
                label: 'Name',
                hintText: 'Enter the name',
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: _descriptionController,
                label: 'Description',
                hintText: 'Enter the description',
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: _locationController,
                label: 'Location',
                hintText: 'Enter the location',
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: _contactController,
                label: 'Contact',
                hintText: 'Enter the contact details',
              ),
              SizedBox(height: 20),
              _buildInputField(
                controller: _timeController,
                label: _isListing ? 'Time of Retrieval' : 'Time of Lost',
                hintText: _isListing ? 'Enter the time of retrieval' : 'Enter the time of lost',
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitPost,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
