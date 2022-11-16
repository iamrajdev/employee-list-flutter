import 'dart:convert';

List<LoginResponseModel> loginResponseModelFromJson(String str) =>
    List<LoginResponseModel>.from(
        json.decode(str).map((x) => LoginResponseModel.fromJson(x)));

String loginResponseModelToJson(List<LoginResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginResponseModel {
  LoginResponseModel({
    this.id,
    required this.name,
    required this.userId,
    required this.password,
  });

  final int? id;
  final String name;
  final String userId;
  final String password;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["id"] ?? null,
        name: json["name"] ?? null,
        userId: json["user_id"] ?? null,
        password: json["password"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_id": userId,
        "password": password,
      };
}
