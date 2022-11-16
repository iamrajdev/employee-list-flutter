import 'dart:convert';

List<EmployeeResponseModel> employeeResponseModelFromJson(String str) {
  var parsed = json.decode(str);
  parsed = parsed.where((value) => value['name'] != null);
  return List<EmployeeResponseModel>.from(
      parsed.map((x) => EmployeeResponseModel.fromJson(x)));
}

String employeeResponseModelToJson(List<EmployeeResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeResponseModel {
  EmployeeResponseModel({
    this.id,
    this.name,
    this.company,
    this.designation,
    this.companyLogo,
  });

  final int? id;
  final String? name;
  final String? company;
  final String? designation;
  final String? companyLogo;

  factory EmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      EmployeeResponseModel(
        id: json["id"] == "null" ? '' : json["id"],
        name: json["name"] == "null" ? '' : json["name"],
        company: json["company"] == "null" ? '' : json["company"],
        designation: json["designation"] == "null" ? '' : json["designation"],
        companyLogo: json["company_logo"] == "null" ? '' : json["company_logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company": company,
        "designation": designation,
        "company_logo": companyLogo,
      };
}
