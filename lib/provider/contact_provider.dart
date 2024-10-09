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
  //Crete all Favorite contact list calling method------
  getAllFavoriteContact() async{
    _contactList = await _db.getAllFavoriteContact();
    notifyListeners();
  }
  //delete data specefic contact from database methord-----
  Future<int> deleteContact (ContactModel contact) {
    return _db.deleteContact(contact.id!);
  }
//find contact by id for clicked and go details page methord--------
  Future<ContactModel> getContactById (int id) async {
    return _db.getContactById(id);
  }
//favorite value change method--------------------------------
  Future<void>updateFavorite(ContactModel contact) async{
    final updatedFavoriteValue = contact.favorate ? 0 : 1;
    final updatedRoId = await _db.updateFavorite(contact.id!, updatedFavoriteValue);
    final position = _contactList.indexOf(contact);
    _contactList[position].favorate = !_contactList[position].favorate;
    notifyListeners();
  }
}