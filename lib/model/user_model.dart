class UserModel {
  String userId;
  String email;
  String name;
  String pic;

  UserModel({required this.userId, required this.email, required this.name, required this.pic});

  // Named constructor for converting JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      pic: json['pic'] ?? '',
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'pic': pic,
    };
  }
}
