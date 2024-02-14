import 'package:flexigadi/Screens/Driver/components/notification.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../Screens/Wallet/screen/home.dart';

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
    double iconSize = MediaQuery.of(context).size.width * 0.05;

    return PreferredSize(
      preferredSize: Size.fromHeight(56.0),
      child: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0.0000001),
          ),
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            WalletContainer(iconSize: iconSize),
          ],
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
          WalletTextContainer(iconSize: iconSize),
          NotificationContainer(iconSize: iconSize),
        ],
      ),
    );
  }
}

class WalletContainer extends StatelessWidget {
  final double iconSize;

  WalletContainer({required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the wallet() function
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WalletScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: lightBlack,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: kPrimaryColor,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}

class WalletTextContainer extends StatelessWidget {
  final double iconSize;

  WalletTextContainer({required this.iconSize});

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.035;

    return Container(
      height: 40.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: lightBlack,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              '100',
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          SizedBox(width: 4.0),
          Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryLightColor,
              border: Border.all(
                color: kPrimaryColor,
                width: 1.0,
              ),
            ),
            child: Center(
              child: Text(
                "₹",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: iconSize * 0.7,
                ),
              ),
            ),
          ),
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
