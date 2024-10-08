import 'dart:io';

import 'package:contact_manager_sqflite/custom_widget/contact_item_view.dart';
import 'package:contact_manager_sqflite/main.dart';
import 'package:contact_manager_sqflite/pages/NewContact_page.dart';
import 'package:contact_manager_sqflite/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  void didChangeDependencies() {
    context.read<ContactProvider>().getAllContacts();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, NewContactPage.routeName),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          onTap: (index){
            setState(() {
              _currentIndex = index;
              if(_currentIndex == 1){
                context.read<ContactProvider>().getAllFavoriteContact();
              }
              if(_currentIndex == 0){
                context.read<ContactProvider>().getAllContacts();
              }
            });
          },
          currentIndex: _currentIndex,
          selectedItemColor: Colors.red,
          selectedFontSize: 20,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'All',
            ),BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),

          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index) {
            final contact = provider.contactList[index];
            return Dismissible(
              key: UniqueKey(),
              confirmDismiss: (direction) {
                return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Delete ${contact.name}?'),
                          content:
                              Text('Are you sure to delete ${contact.name}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('NO'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        ));
              },
              background: Container(
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red.shade300,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.white,
                ),
              ),
              direction: DismissDirection.endToStart,
              child: ContactItemView(contact: contact, onFavoriteButtonChange: (contact){
                provider.updateFavorite(contact);
              },),
              onDismissed: (direction) {
                context.read<ContactProvider>().deleteContact(contact);
              },
            );
          },
        ),
      ),
    );
  }
}
