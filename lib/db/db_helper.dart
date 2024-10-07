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


  Future<Database> _open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, 'contact.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version){
      db.execute(createTableContact);
    });
  }

  Future<int> insertContact(ContactModel contact) async{
    final db = await _open();
    return db.insert(tableContact, contact.toMap());
  }
}