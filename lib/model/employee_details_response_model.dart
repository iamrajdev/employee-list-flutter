import 'dart:convert';

EmployeeDetailsResponseModel employeeDetailsResponseModelFromJson(String str) =>
    EmployeeDetailsResponseModel.fromJson(json.decode(str)[0]);

String employeeDetailsResponseModelToJson(
        List<EmployeeDetailsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeDetailsResponseModel {
  EmployeeDetailsResponseModel({
    this.id,
    this.name,
    this.rating,
    this.company,
    this.interests,
    this.viewMore,
    this.designation,
    this.companyLogo,
    this.jobDescripton,
  });

  final int? id;
  final String? name;
  final String? rating;
  final String? company;
  final String? interests;
  final String? viewMore;
  final String? designation;
  final String? companyLogo;
  final String? jobDescripton;

  factory EmployeeDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsResponseModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        rating: json["rating"] == null ? null : json["rating"],
        company: json["company"] == null ? null : json["company"],
        interests: json["interests"] == null ? null : json["interests"],
        viewMore: json["view_more"] == null ? null : json["view_more"],
        designation: json["designation"] == null ? null : json["designation"],
        companyLogo: json["company_logo"] == null ? null : json["company_logo"],
        jobDescripton:
            json["job_descripton"] == null ? null : json["job_descripton"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rating": rating,
        "company": company,
        "interests": interests,
        "view_more": viewMore,
        "designation": designation,
        "company_logo": companyLogo,
        "job_descripton": jobDescripton,
      };
}
