import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../components/active.dart';
import '../components/latest.dart';
import '../components/closed.dart';

class RequirementList extends StatefulWidget {
  const RequirementList({Key? key}) : super(key: key);

  @override
  State<RequirementList> createState() => _HomeState();
}

class _HomeState extends State<RequirementList> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Material(
              child: Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.04,
                    bottom: screenHeight * 0.01,
                    left: screenHeight * 0.05,
                    right: screenHeight * 0.05),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 242, 240, 240),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 43, 41, 41).withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                height: screenHeight * 0.15,
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.025,
                      left: screenHeight * 0.02,
                      right: screenHeight * 0.02,
                      bottom: screenHeight * 0.025),
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kPrimaryColor,
                  ),
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Container(
                        height: screenHeight * 0.10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: kPrimaryColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Latest"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: screenHeight * 0.10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: kPrimaryColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Active"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: screenHeight * 0.10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: kPrimaryColor, width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Closed"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Latest(),
                  Active(),
                  Closed(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
