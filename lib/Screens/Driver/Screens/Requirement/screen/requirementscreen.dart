import 'package:flutter/material.dart';

import '../../Requirement/components/requirement_list.dart';
import '../../../components/uppermenu.dart';
import '../../../components/bottommenu.dart';

class RequirementdriverScreen extends StatefulWidget {
  const RequirementdriverScreen({Key? key}) : super(key: key);

  @override
  _HomedriverScreenState createState() => _HomedriverScreenState();
}

class _HomedriverScreenState extends State<RequirementdriverScreen> {
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
        child: UpperMenu(title: 'Requirements'), // Use UpperMenu as the app bar
      ),
      body: Column(
        children: [
          Expanded(
            child: RequirementList(),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: BottomMenuBar(
              initialIndex: 1,
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
  runApp(const RequirementdriverScreen());
}
