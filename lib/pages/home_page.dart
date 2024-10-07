import 'dart:io';

import 'package:contact_manager_sqflite/main.dart';
import 'package:contact_manager_sqflite/pages/NewContact_page.dart';
import 'package:contact_manager_sqflite/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ContactProvider>().getAllContacts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, NewContactPage.routeName),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index){
            final contact = provider.contactList[index];
            return ListTile(
              title: Text(contact.name,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.orange),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.mobile,style: TextStyle(fontSize: 18,color: Colors.blue),),
                  Text(contact.email)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
