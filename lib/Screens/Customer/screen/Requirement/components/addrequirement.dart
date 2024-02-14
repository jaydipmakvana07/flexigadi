import 'package:flutter/material.dart';

import 'add.dart';
import '../../../components/uppermenu.dart';
import '../../../components/bottommenu.dart';

class AddRequirementScreen extends StatefulWidget {
  const AddRequirementScreen({Key? key}) : super(key: key);

  @override
  _HomedriverScreenState createState() => _HomedriverScreenState();
}

class _HomedriverScreenState extends State<AddRequirementScreen> {
  bool isKeyboardVisible = false;

  void _onFocusChange(bool hasFocus) {
    setState(() {
      isKeyboardVisible = hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Add this line to prevent screen resizing
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child:
            UpperMenu(title: 'Add Requirement'), // Use UpperMenu as the app bar
      ),
      body: Column(
        children: [
          Expanded(
            child: CabBookingForm(onFocusChange: _onFocusChange),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: BottomMenuBar(
              initialIndex: 2,
              onTabChanged: (index) {
                // Handle the tab change if needed
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const AddRequirementScreen());
}
