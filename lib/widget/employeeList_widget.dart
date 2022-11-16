import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_info/widget/small_grey_text_icon.dart';
import 'package:flutter/material.dart';

class EmployeeListWidget extends StatelessWidget {
  final String name;
  final String company;
  final String designation;
  final String company_logo;
  final VoidCallback? onTap;
  const EmployeeListWidget(
      {super.key,
      required this.name,
      required this.company,
      required this.designation,
      required this.company_logo,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (name != "null")
                      Text(name.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    if (company != "null")
                      SmallGreyTextIcon(
                          text: company, icon: Icons.apartment_outlined),
                    const SizedBox(height: 4),
                    if (designation != "null")
                      SmallGreyTextIcon(
                          text: designation, icon: Icons.badge_outlined),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                if (company_logo != "null")
                  CachedNetworkImage(
                    imageUrl: company_logo,
                    width: 50,
                    height: 50,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
