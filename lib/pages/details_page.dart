import 'dart:io';

import 'package:contact_manager_sqflite/pages/NewContact_page.dart';
import 'package:contact_manager_sqflite/provider/contact_provider.dart';
import 'package:contact_manager_sqflite/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const DetailsPage({super.key});
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late int id;
  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, NewContactPage.routeName, arguments: id)
              .then((_){setState(() {

              });});
            },
            child: Text('EDIT'),
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => FutureBuilder(
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
                            'assets/images/images.png',
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
                    title: Text(
                      contact.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contact.group),
                    trailing: Text(contact.dob!),
                  ),
                  ListTile(
                    title: Text(contact.mobile),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            _callNumber(contact.mobile);
                          },
                          icon: const Icon(Icons.call),
                        ),
                        IconButton(
                          onPressed: () {
                            _sendSms(contact.mobile);
                          },
                          icon: const Icon(Icons.sms),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(contact.email),
                    trailing: IconButton(
                        onPressed: () {
                          _sendEmail(contact.email);
                        },
                        icon: const Icon(Icons.email)),
                  ),
                  ListTile(
                    title: Text(contact.address),
                    trailing: IconButton(
                        onPressed: () {
                          _openMap(contact.address);
                        },
                        icon: const Icon(Icons.location_on_rounded)),
                  ),
                  ListTile(
                    title: Text(contact.website!),
                    trailing: IconButton(
                        onPressed: () {
                          _openWebsite(contact.website);
                        },
                        icon: const Icon(Icons.web)),
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

  void _callNumber(String mobile) async{
    final url = 'tel:$mobile';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannot Perform this task');
    }
  }

  void _sendSms(String mobile) async{
    final url = 'sms:$mobile';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannot perform this task');
    }
  }

  void _sendEmail(String email) async{
    final url = 'mailto:$email';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannor perform this task');
    }
  }

  void _openMap(String address) async{
    final url = 'geo:$address';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannot perform this task');
    }
  }

  void _openWebsite(String? website) async{
    final url = 'https:$website';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannot perform this task');
    }
  }
}
