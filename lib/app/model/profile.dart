class Profile {
  Profile({
    this.name,
    this.mobile,
  });

  Profile.fromJson(dynamic json) {
    name = json['name'];
    mobile = json['phone_number'];
  }

  String? name;
  String? mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone_number'] = mobile;
    return map;
  }
}
