import '../components/notifications.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

void main() {
  runApp(UpperMenu(
    title: 'home',
  ));
}

class UpperMenu extends StatelessWidget {
  final String title;

  UpperMenu({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: title),
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  MyCustomAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(54.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56.0),
      child: AppBar(
        automaticallyImplyLeading:
            false, // Set to false to remove the default back button
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0.0000001),
          ),
        ),
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
        actions: [
          NotificationContainer(
              iconSize: MediaQuery.of(context).size.width * 0.05),
        ],
      ),
    );
  }
}

class NotificationContainer extends StatelessWidget {
  final double iconSize;

  NotificationContainer({required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationsListScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: lightBlack,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications,
              color: kPrimaryColor,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
