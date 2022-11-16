import 'package:employee_info/provider/auth_provider.dart';
import 'package:employee_info/screen/resources/colors.dart';
import 'package:employee_info/screen/resources/route_manager.dart';
import 'package:employee_info/screen/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            myHeaderDrawer(),
            menuItem(
              text: AppStrings.employeeList,
              icon: Icons.groups_outlined,
              onClicked: () =>
                  Navigator.of(context).pushReplacementNamed(Routes.mainRoute),
            ),
            const Divider(
              color: Colors.grey,
            ),
            menuItem(
              text: AppStrings.logOut,
              icon: Icons.logout,
              onClicked: () => {
                AuthProvider().logOut(),
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget myHeaderDrawer() {
    return Container(
      color: AppColor.primary,
      height: 100,
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/logo.png'))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  AppStrings.appName,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  AppStrings.listOfEmployeeInfo,
                  style: TextStyle(fontSize: 12, color: Colors.white60),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget menuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.blue;
    const size = 30.0;
    return InkWell(
      onTap: onClicked,
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
          size: size,
        ),
        title: Text(text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
