import 'dart:io';

import 'package:contact_manager_sqflite/main.dart';
import 'package:contact_manager_sqflite/models/contact_model.dart';
import 'package:contact_manager_sqflite/pages/details_page.dart';
import 'package:contact_manager_sqflite/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactItemView extends StatelessWidget {
  const ContactItemView({
    super.key,
    required this.contact,
    required this.onFavoriteButtonChange,
  });

  final ContactModel contact;
  final Function(ContactModel) onFavoriteButtonChange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => Navigator.pushNamed(context, DetailsPage.routeName,
            arguments: contact.id),
        title: Text(
          contact.name,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.mobile,
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
            Text(contact.email)
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            onFavoriteButtonChange(contact);
          },
          icon: Icon(
            contact.favorate ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
        leading: ClipOval(
            child: contact.image == null
                ? Image.asset(
              'assets/images/images.png',
            )
                : Image.file(
              File(contact.image!),
            ),
        )
    );
  }
}
