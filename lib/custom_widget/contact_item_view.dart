import 'dart:io';

import 'package:contact_manager_sqflite/models/contact_model.dart';
import 'package:contact_manager_sqflite/pages/details_page.dart';
import 'package:flutter/material.dart';

class ContactItemView extends StatelessWidget {
  const ContactItemView({super.key, required this.contact});

  final ContactModel contact;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=> Navigator.pushNamed(context, DetailsPage.routeName, arguments: contact.id),
        title: Text(contact.name,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.orange),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.mobile,style: const TextStyle(fontSize: 18,color: Colors.blue),),
            Text(contact.email)
          ],
        ),
        trailing: const Icon(Icons.call),
        leading:  ClipOval(child: Image.file(File(contact.image!)))
    );
  }
}
