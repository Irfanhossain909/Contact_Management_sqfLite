import 'package:contact_manager_sqflite/db/db_helper.dart';
import 'package:contact_manager_sqflite/models/contact_model.dart';
import 'package:flutter/foundation.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> _contactList = [];
  List<ContactModel> get contactList => _contactList;

//Create a DbHelper Object----------------------
  final _db = DbHelper();
  //create addContact into add Data in Database----
  Future<void> addContact(ContactModel contact) async{
    final rowId = await _db.insertContact(contact);
    contact.id = rowId;
    _contactList.add(contact);
    notifyListeners();
  }
  //Crete all contact calling methord------
  getAllContacts() async{
    _contactList = await _db.getAllContact();
    notifyListeners();
  }
  //delete data specefic contact from database methord-----
  Future<int> deleteContact (ContactModel contact) {
    return _db.deleteContact(contact.id!);
  }

  Future<ContactModel> getContactById (int id) async {
    return _db.getContactById(id);
  }
}