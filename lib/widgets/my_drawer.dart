import 'package:attendance_uni_app/configs/images_paths.dart';
import 'package:attendance_uni_app/utilities/routes.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.5),
        child: ListView(
          children: [
            // AppBar(
            //   automaticallyImplyLeading: false,
            //   backgroundColor: Theme.of(context).hintColor,
            //   title: Text(
            //     'Hello CR!',
            //     style: TextStyle(
            //       color: Theme.of(context).colorScheme.secondary,
            //     ),
            //     // textAlign: TextAlign.center,
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).hintColor,
                  Theme.of(context).cardColor,
                ],
              )),
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.015,
                    left: size.height * 0.015,
                    right: size.height * 0.015),
                child: Text(
                  'Hello CR!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            UserAccountsDrawerHeader(
              currentAccountPicture: Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.005),
                child: const CircleAvatar(
                  foregroundImage: AssetImage(userImg),
                ),
              ),
              accountName: Text(
                '',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                '',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
              currentAccountPictureSize:
                  Size(size.height * 0.1, size.width * 0.3),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).hintColor,
                  Theme.of(context).cardColor,
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.025),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(size.height * 0.05),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).hintColor,
                      Theme.of(context).cardColor,
                    ],
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.data_saver_on_sharp,
                      color: Theme.of(context).appBarTheme.backgroundColor),
                  title: Text(
                    'Stored Data',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).appBarTheme.backgroundColor),
                  ),
                  onTap: () async {
                    await Navigator.of(context)
                        .pushNamed(MyRoutes.showDataScreenRoute);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
