class ContactUser {
  String? id;
  String? name;
  String? phone;
  ContactUser({this.name, this.phone, this.id});
  Map<String, dynamic> toJson() {
    return {"name": name, "phone": phone, "id": id};
  }

  ContactUser.fromJson(Map<String, dynamic> json)
    : this(name: json["name"], phone: json["phone"], id: json["id"]);
}
