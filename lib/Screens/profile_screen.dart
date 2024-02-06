import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrteam/Services/localStorage.dart';
import 'package:permission_handler/permission_handler.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String? _latitude;
  String? _longitude;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  LocalStorage localStorage = LocalStorage();
  final User? user = FirebaseAuth.instance.currentUser;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _getUserLocation();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _firstName = prefs.getString('firstName') ?? '';
      _lastName = prefs.getString('lastName') ?? '';
      _email = user!.email.toString();
    });
  }

  Future<void> _getUserLocation() async {
    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _longitude = position.longitude.toString();
          _latitude = position.latitude.toString();
          loading = false;
        });
        log("User's location: ${position.latitude}, ${position.longitude}");
      } catch (e) {
        log("Error getting user's location: $e");
      }
    } else {
      log("Location permission denied by the user.");
    }
  }

  Future<void> _selectProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? const Icon(Icons.person, size: 50, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectProfileImage,
              child: const Text('Select Profile Image'),
            ),
            const SizedBox(height: 16),
            if (_firstName == '' || _lastName == '')
              Column(
                children: [
                  TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _saveUserData();
                      _loadUserData();
                    },
                    child: const Text('Save User Data'),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            if (_firstName != '') Text('First Name: $_firstName'),
            const SizedBox(height: 16),
            if (_firstName != '') Text('Last Name: $_lastName'),
            const SizedBox(height: 16),
            Text('Email: $_email'),
            const SizedBox(height: 16),
            loading
                ? LinearProgressIndicator(
                    value: 0.7,
                    minHeight: 2, // Adjust the height of the progress bar
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Latitude: $_latitude'),
                      const SizedBox(height: 16),
                      Text('Longitude: $_longitude'),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  void _saveUserData() {
    localStorage.saveUserData(
        _firstNameController.text, _lastNameController.text);
  }
}
