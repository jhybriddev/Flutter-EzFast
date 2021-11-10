
enum UserState { available, away, busy }

class User {

  String id;
  String name = "";
  String surname;
  String email;
  String dob = "";
  String gender = "";
  String phoneNumber;
  String imageUrl;
  String selectedReason = "";
  String selectedType = "";
  String fastStart = "";
  String fastEnd = "";
  bool isSocial = false;
  String deviceToken = '';

  User({this.id, this.name, this.surname, this.email, this.phoneNumber, this.imageUrl,
    this.selectedReason, this.selectedType, this.fastStart, this.fastEnd, this.isSocial,
  this.dob, this.gender, this.deviceToken});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        surname = data['surname'],
        dob = data['dob'],
        gender = data['gender'],
        email = data['email'],
        imageUrl = data['imageUrl'],
        deviceToken = data['device_token'],
        phoneNumber = data['phoneNumber'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // 'surname': surname,
      'email': email,
      'dob': dob,
      'gender': gender,
      'selectedReason': selectedReason,
      'selectedType': selectedType,
      'fastStart': fastStart,
      'fastEnd': fastEnd,
      'isSocial': isSocial,
      // 'imageUrl': imageUrl,
      // 'phoneNumber': phoneNumber,
    };
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    // map["password"] = password;
    // map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    // map["phone"] = phone;
    // map["address"] = address;
    // map["bio"] = bio;
    // map["media"] = image?.toMap();
    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    // map["thumb"] = image?.thumb;
    map["device_token"] = deviceToken;
    return map;
  }
}