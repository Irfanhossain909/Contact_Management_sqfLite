class ContactModel {
  String? id;
  String name;
  String email;
  String address;
  String group;
  String gender;
  String? website;
  String? image;
  bool favorate;
  String? dob;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.group,
    required this.gender,
    this.website,
    this.image,
    this.favorate = false,
    this.dob,
  });
}