import 'package:employee_info/model/employee_response_model.dart';
import 'package:employee_info/model/menu_item_option_model.dart';
import 'package:employee_info/provider/auth_provider.dart';
import 'package:employee_info/provider/employee_provider.dart';
import 'package:employee_info/screen/employee_details/employee_details.dart';
import 'package:employee_info/screen/resources/colors.dart';
import 'package:employee_info/screen/resources/route_manager.dart';
import 'package:employee_info/screen/resources/strings_manager.dart';
import 'package:employee_info/widget/custom_page_route.dart';
import 'package:employee_info/widget/drawer/navigation_drawer.dart';
import 'package:employee_info/widget/employeeList_widget.dart';
import 'package:employee_info/widget/menu_items.dart';
import 'package:employee_info/widget/no_internet_connection.dart';
import 'package:employee_info/widget/skelton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late Future<List<EmployeeResponseModel>?> _employeeModelList;

  @override
  void initState() {
    getAllEmployee();
    super.initState();
  }

  Future<void> getAllEmployee() async {
    setState(() {
      _employeeModelList = Provider.of<EmployeeProvider>(context, listen: false)
          .getAllEmployee();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SafeArea(child: NavigationDrawerWidget()),
      appBar: AppBar(
        title: const Text(AppStrings.employeeList),
        backgroundColor: AppColor.primary,
        actions: [
          PopupMenuButton<MenuItemOption>(
            icon: const Icon(Icons.more_vert),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              ...MenuItemsModel.itemList.map(buildItem).toList(),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getAllEmployee,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<List<EmployeeResponseModel>?>(
                future: _employeeModelList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return skeltonBuild();
                          });
                    case ConnectionState.done:
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Flexible(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return EmployeeListWidget(
                                name: snapshot.data![index].name.toString(),
                                company:
                                    snapshot.data![index].company.toString(),
                                designation: snapshot.data![index].designation
                                    .toString(),
                                company_logo: snapshot.data![index].companyLogo
                                    .toString(),
                                onTap: () => Navigator.push(
                                  context,
                                  CustomPageRoute(
                                    child: EmployeeDetails(
                                        id: snapshot.data![index].id),
                                    direction: AxisDirection.left,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2),
                          child: NoInternetConnection(
                              message: snapshot.error.toString()),
                        );
                      }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget skeltonBuild() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Skelton.rectangular(
                    height: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    )),
                const SizedBox(height: 4),
                Skelton.rectangular(
                    height: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    )),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Skelton.rectangular(
              height: 40,
              width: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )),
        ],
      ),
    );
  }

  PopupMenuItem<MenuItemOption> buildItem(MenuItemOption item) =>
      PopupMenuItem<MenuItemOption>(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: Colors.blue, size: 20),
            const SizedBox(width: 10),
            Text(item.title),
          ],
        ),
      );

  void onSelected(BuildContext context, MenuItemOption item) {
    if (item == MenuItemsModel.logOut) {
      AuthProvider().logOut();
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }
}
