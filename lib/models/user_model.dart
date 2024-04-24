
class UserModel{
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? address;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNo: json["phoneNo"],
    address: json["address"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phoneNo": phoneNo,
    "address": address,
    "password": password,
  };

  UserModel({required this.id,required this.name,required this.email,required this.phoneNo,required this.address,required this.password});

}