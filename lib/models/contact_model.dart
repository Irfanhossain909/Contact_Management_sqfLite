
const tableContact = 'tbl_contact';
const tblContactColId = 'id';
const tblContactColName = 'name';
const tblContactColMobile = 'mobile';
const tblContactColEmail = 'email';
const tblContactColAddress = 'address';
const tblContactColGroup = 'contact_group';
const tblContactColGender = 'gender';
const tblContactColWebsite = 'website';
const tblContactColImage = 'image';
const tblContactColFavorite = 'favorite';
const tblContactColDob = 'dob';


class ContactModel {
  String? id;
  String name;
  String mobile;
  String email;
  String address;
  String group;
  String gender;
  String? website;
  String? image;
  bool favorate;
  String? dob;

  ContactModel({
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.group,
    required this.gender,
    this.website,
    this.image,
    this.favorate = false,
    this.dob,
  });

  Map<String, dynamic> toMap () {
    final map = <String, dynamic>{
      tblContactColName : name,
      tblContactColMobile : mobile,
      tblContactColWebsite : website,
      tblContactColImage : image,
      tblContactColGroup : group,
      tblContactColGender : gender,
      tblContactColEmail : email,
      tblContactColAddress : address,
      tblContactColDob : dob,
      tblContactColFavorite : favorate ? 1 : 0,
    };
    return map;
  }
}