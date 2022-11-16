import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_info/helper/utils.dart';
import 'package:employee_info/model/employee_details_response_model.dart';
import 'package:employee_info/provider/employee_provider.dart';
import 'package:employee_info/screen/resources/colors.dart';
import 'package:employee_info/screen/resources/strings_manager.dart';
import 'package:employee_info/widget/small_grey_text_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetails extends StatefulWidget {
  final int? id;
  const EmployeeDetails({super.key, required this.id});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  late Future<EmployeeDetailsResponseModel> futureEmployeeDetails;

  @override
  void initState() {
    futureEmployeeDetails =
        Provider.of<EmployeeProvider>(context, listen: false)
            .getEmployeeDetailsById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.employeeDetails),
          backgroundColor: AppColor.primary,
        ),
        body: Center(
          child: FutureBuilder<EmployeeDetailsResponseModel>(
            future: futureEmployeeDetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return employeeDetailsWidget(
                  context,
                  snapshot.data,
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ));
  }

  Widget employeeDetailsWidget(
      BuildContext context, EmployeeDetailsResponseModel? data) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SmallGreyTextIcon(
                              text: AppStrings.name,
                              icon: Icons.person_outline),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(data!.name.toString(),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const SmallGreyTextIcon(
                              text: AppStrings.rating,
                              icon: Icons.star_half_outlined),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(data.rating.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue.shade300,
                    child: Text(
                      getInitialsWord(data.name!.toUpperCase().toString()),
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SmallGreyTextIcon(
                      text: AppStrings.interest, icon: Icons.favorite_outline),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(data.interests.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SmallGreyTextIcon(
                      text: AppStrings.designation,
                      icon: Icons.school_outlined),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(data.designation.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 8),
              const SmallGreyTextIcon(
                  text: AppStrings.companyLogo,
                  icon: Icons.corporate_fare_outlined),
              const SizedBox(
                height: 4,
              ),
              CachedNetworkImage(
                imageUrl: data.companyLogo.toString(),
                height: 50,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                height: 8,
              ),
              const SmallGreyTextIcon(
                  text: AppStrings.jobDescription,
                  icon: Icons.description_outlined),
              const SizedBox(
                height: 4,
              ),
              Text(data.jobDescripton.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.black)),
              const SizedBox(
                height: 8,
              ),
              const SmallGreyTextIcon(
                  text: AppStrings.wantToKnowMore, icon: Icons.link_outlined),
              const SizedBox(
                height: 4,
              ),
              InkWell(
                onTap: () => launchUrl(Uri.parse(data.viewMore.toString())),
                child: const Text(
                  AppStrings.viewMore,
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
