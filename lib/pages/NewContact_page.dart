import 'dart:io';

import 'package:contact_manager_sqflite/main.dart';
import 'package:contact_manager_sqflite/models/contact_model.dart';
import 'package:contact_manager_sqflite/provider/contact_provider.dart';
import 'package:contact_manager_sqflite/utils/constance.dart';
import 'package:contact_manager_sqflite/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewContactPage extends StatefulWidget {
  static const String routeName = '/new';

  const NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _webController = TextEditingController();
  DateTime? _selectedDate;
  String? _imagePath;
  Gender? gender;
  String? _group;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contact Name (Required)',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Name!!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contact Number (Required)',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Number!!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Contact Email (Required)',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Email!!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Address (Required)',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Address!!';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: _webController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Website (Optional)',
                  prefixIcon: Icon(Icons.web),
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _selectDateOfBirth,
                      child: Text(_selectedDate == null
                          ? 'Date Of Birth'
                          : getFormetedDate(_selectedDate!)!),
                    ),
                    Row(
                      children: [
                        Text(Gender.Male.name),
                        Radio<Gender>(
                          value: Gender.Male,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                        Text(Gender.Female.name),
                        Radio<Gender>(
                          value: Gender.Female,
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(border: InputBorder.none),
                  value: _group,
                  hint: const Text('Select group'),
                  isExpanded: true,
                  items: groups
                      .map((group) => DropdownMenuItem(
                            value: group,
                            child: Text(group),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _group = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Select Group';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(children: [
                    Card(
                        child: _imagePath == null
                            ? const Icon(
                                Icons.person,
                                size: 100,
                              )
                            : Image.file(
                                fit: BoxFit.cover,
                                File(_imagePath!),
                                width: 100,
                                height: 100,
                              )),
                    Positioned(
                      right: -20,
                      top: -10,
                      child: TextButton(
                        onPressed: _imageReset,
                        child: _imagePath == null ? const Text(
                          'X',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ) : const Text(
                          'X',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ),
                    ),
                  ]),
                  Column(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          _getImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text('Gallery'),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _save() {
    if (gender == null) {
      showMsg(context, 'Please Select Gender');
      return;
    }

    if (_formKey.currentState!.validate()) {
      final contact = ContactModel(
        name: _nameController.text,
        mobile: _mobileController.text,
        email: _emailController.text,
        address: _addressController.text,
        website: _webController.text.isEmpty ? null : _webController.text,
        group: _group!,
        gender: gender!.name,
        image: _imagePath,
        dob: getFormetedDate(_selectedDate)
      );
      context.read<ContactProvider>().addContact(contact)
      .then((value){
        showMsg(context, 'Saved');
        Navigator.pop(context);
      })
      .catchError((error){
        showMsg(context, error.toString());
      });
    }
  }

  void _selectDateOfBirth() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      setState(() {
        _imagePath = xFile.path;
      });
    }
  }
  void _imageReset() {
    setState(() {
      _imagePath = null;
    });
  }
}
