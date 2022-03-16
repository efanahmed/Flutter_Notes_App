import 'package:flutter/material.dart';
import 'package:flutter_todo_apps/screens/categories.dart';
import 'package:flutter_todo_apps/screens/home_screen.dart';
import 'package:flutter_todo_apps/screens/login_screen.dart';

class DrawerNavigaton extends StatefulWidget {
  const DrawerNavigaton({Key? key}) : super(key: key);

  @override
  _DrawerNavigatonState createState() => _DrawerNavigatonState();
}

class _DrawerNavigatonState extends State<DrawerNavigaton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    ''),
              ),
              accountName: Text('Efan Mozumder'),
              accountEmail: Text('efanmozumder@gmail.com'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.view_list),
              title: const Text('Categories'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoriesScreen()));
              },
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}