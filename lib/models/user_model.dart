class UserModel {
  String? uid;
  String? token;
  String? phone;
  String? password;
  String? country;

  UserModel({
    this.uid,
    this.token,
    this.phone,
    this.password,
    this.country,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    token = json['token'];
    // age = json['age'];
    phone = json['phone'];
    password = json['password'];
    country = json['country'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['phone'] = phone ?? "";
    data['password'] = password!;
    data['country'] = country ?? "";
    return data;
  }
}
