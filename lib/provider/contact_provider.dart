import 'package:contact_manager_sqflite/db/db_helper.dart';
import 'package:contact_manager_sqflite/models/contact_model.dart';
import 'package:flutter/foundation.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> _contactList = [];
  List<ContactModel> get contactList => _contactList;


  final db = DbHelper();
  Future<int> addContact(ContactModel contact){
    return db.insertContact(contact);
  }
}