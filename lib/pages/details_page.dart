import 'dart:io';

import 'package:contact_manager_sqflite/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  static const String routeName = '/details';

  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute
        .of(context)!
        .settings
        .arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) =>
            FutureBuilder(
              future: provider.getContactById(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final contact = snapshot.data!;
                  return ListView(
                    padding: EdgeInsets.all(8.0),
                    children: [
                      Card(
                        child: contact.image == null
                            ? Image.asset(
                          'assets/images/images.pgn',
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        )
                            : Image.file(
                          File(contact.image!),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),

                      ListTile(
                        title: Text(contact.name,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                        subtitle: Text(contact.group),
                        trailing: Text(contact.dob!),
                      ),
                      ListTile(
                        title: Text(contact.mobile),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.call),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.sms),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(contact.email),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.email)),
                      ),
                      ListTile(
                        title: Text(contact.address),
                        trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.location_on_rounded)),
                      ),
                      ListTile(
                        title: Text(contact.website!),
                        trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.web)),
                      ),


                    ],
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something Wrong'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
      ),
    );
  }
}
