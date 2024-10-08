import 'package:contact_manager_sqflite/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  final createTableContact = '''create table $tableContact(
  $tblContactColId integer primary key autoincrement,
  $tblContactColName text,
  $tblContactColEmail text,
  $tblContactColMobile text,
  $tblContactColAddress text,
  $tblContactColWebsite text,
  $tblContactColDob text,
  $tblContactColGender text,
  $tblContactColGroup text,
  $tblContactColImage text,
  $tblContactColFavorite integer)''';

// Create Database query-----------------------
  Future<Database> _open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, 'contact.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version){
      db.execute(createTableContact);
    });
  }

// Insert Into Database query------------------
  Future<int> insertContact(ContactModel contact) async{
    final db = await _open();
    return db.insert(tableContact, contact.toMap());
  }

//get All Data as a list query----------------------
  Future<List<ContactModel>> getAllContact() async {
    final db = await _open();
    final mapList = await db.query(tableContact, orderBy: tblContactColName);
    return List.generate(mapList.length, (index)=> ContactModel.fromMap(mapList[index]));
  }

//Delete A specefic contact from database query--------
  Future<int> deleteContact(int id) async{
    final db = await _open();
    return db.delete(tableContact, where: '$tblContactColId = ?', whereArgs: [id]);
  }
// get one contact by id
  Future<ContactModel> getContactById(int id) async {
    final db = await _open();
    final mapList = await db.query(tableContact, where: '$tblContactColId = ?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }
//change value for the favorite query-----------------
  Future<int> updateFavorite(int id, int value) async{
    final db = await _open();
    return db.update(tableContact, {tblContactColFavorite : value}, where: '$tblContactColId = ?', whereArgs: [id]);
  }
}