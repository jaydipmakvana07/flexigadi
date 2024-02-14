import 'package:flexigadi/Screens/Customer/screen/Home/screen/homescreen.dart';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../../../constants.dart';
import '../screen/Available/screen/availablescreen.dart';
import '../../Calculator/screen/calculator_customer.dart';
import '../screen/Profile/screen/profilescreen.dart';
import '../screen/Requirement/screen/requirementscreen.dart';

class BottomMenuBar extends StatefulWidget {
  final ValueChanged<int>? onTabChanged; // Add the callback
  final int initialIndex; // Add the initialIndex property

  const BottomMenuBar({Key? key, this.onTabChanged, this.initialIndex = 0})
      : super(key: key);

  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  int _selectedTabIndex = 0;

  List<Color> iconColors = [
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
    kPrimaryLightColor,
  ];

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialIndex; // Set initialIndex in initState
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _selectedTabIndex,
      height: 50.0,
      items: <Widget>[
        Icon(Icons.directions_car, size: 30, color: iconColors[0]),
        Icon(Icons.list, size: 30, color: iconColors[1]),
        Icon(Icons.home, size: 30, color: iconColors[2]),
        Icon(Icons.calculate, size: 30, color: iconColors[3]),
        Icon(Icons.person, size: 30, color: iconColors[4]),
      ],
      color: kPrimaryColor,
      buttonBackgroundColor: kPrimaryColor,
      backgroundColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 300),
      onTap: (index) {
        setState(() {
          _selectedTabIndex = index;

          // Call the onTabChanged callback with the selected index
          if (widget.onTabChanged != null) {
            widget.onTabChanged!(index);
          }

          // Handle navigation based on the selected tab index
          // You can use a Navigator or any other navigation logic here
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AvailableScreen(),
              ));
              // Navigate to 1st available
              break;
            case 1:
              // Navigate to 2nd requirement
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => RequirementScreen(),
              ));
              break;
            case 2:
              // Navigate to Home
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomecustomerScreen(),
              ));
              break;
            case 3:
              // Navigate to Calculator
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Calculator(),
              ));
              break;
            case 4:
              // Navigate to Profile
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Profile(),
              ));

              break;
            default:
              break;
          }
        });
      },
    );
  }
}
