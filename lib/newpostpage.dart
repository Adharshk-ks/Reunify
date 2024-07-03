import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewPostPage extends StatefulWidget {
  const NewPostPage({Key? key}) : super(key: key);

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  File? _image;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitPost() {
    // Implement the functionality for submitting the post
    final name = _nameController.text;
    final location = _locationController.text;
    final contact = _contactController.text;
    // You can now use these values as needed, for example, to send to a backend server
    print('Name: $name, Location: $location, Contact: $contact, Image: $_image');
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
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
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
              _buildInputField(
                controller: _nameController,
                label: 'Name',
                hintText: 'Enter the name',
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
              SizedBox(
                width: double.infinity, // Full width button
                child: ElevatedButton(
                  onPressed: _submitPost,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple, // Background color
                    onPrimary: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(vertical: 15), // Button height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
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
