import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screen/addavailable.dart';
import '../../../../../constants.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class Availableagent extends StatefulWidget {
  @override
  _AvailableState createState() => _AvailableState();
}

class Item {
  String cityFrom;
  String cityTo;
  String carType;

  Item(this.cityFrom, this.cityTo, this.carType);
}

class _AvailableState extends State<Availableagent> {
  String selectedCityFrom = "";
  String selectedCityTo = ""; // Initialize selected city
  String selectedCar = ""; // Initialize selected car

  @override
  Widget build(BuildContext context) {
    final List<Item> items = [
      Item("Ahmedabad", "Surat", "Sedan"),
      Item("Surat", "Ahmedabad", "Xuv"),
      Item("Bhavnagar", "Surat", "Suv"),
      Item("Vadodara", "Bhavnagar", "Sedan"),
      Item("Rajkot", "Ahmedabad", "Xuv"),
      Item("Junagadh", "Rajkot", "Sedan")
    ];
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _showFilterDialog(context);
                },
                child: Container(
                  height: screenWidth * 0.15,
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt,
                        size: screenWidth * 0.07,
                        color: kPrimaryColor, // Icon color
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenWidth * 0.015,
                          // Set your desired padding
                        ),
                        child: Text(
                          'Filter',
                          style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor, // Text color
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAvailableScreen()),
                  );
                },
                child: Container(
                  height: screenWidth * 0.15,
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.add_circle,
                        size: screenWidth * 0.07,
                        color: kPrimaryColor, // Icon color
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenWidth * 0.00,
                          left: screenWidth * 0.01,
                          // Set your desired padding
                        ),
                        child: Text(
                          'Add Your Car',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor, // Text color
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: (items.isEmpty ||
                    items.every((item) => ((selectedCityFrom.isNotEmpty &&
                            item.cityFrom != selectedCityFrom) ||
                        (selectedCityTo.isNotEmpty &&
                            item.cityTo != selectedCityTo) ||
                        (selectedCar.isNotEmpty &&
                            item.carType != selectedCar))))
                ? Center(
                    // Show this content when the list is empty
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/map.svg', // Replace with your SVG file path
                          height: screenHeight * 0.3,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'There is No Any Available Car',
                          style: TextStyle(
                            fontSize: screenHeight * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      String cityFrom = items[index].cityFrom;
                      String cityTo = items[index].cityTo;
                      String carType = items[index].carType;
                      if ((selectedCityFrom.isNotEmpty &&
                              cityFrom != selectedCityFrom) ||
                          (selectedCityTo.isNotEmpty &&
                              cityTo != selectedCityTo) ||
                          (selectedCar.isNotEmpty && carType != selectedCar)) {
                        return SizedBox
                            .shrink(); // Hide the container if city or car type doesn't match selected criteria
                      }
                      return MyContainer(
                        placeFrom: cityFrom,
                        placeTo: cityTo,
                        carType: carType,
                        month: 'JANUARY-2024',
                        date: '26',
                        day: '1 day',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: Text('Filter Options'),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: screenWidth * 0.7,
              padding: EdgeInsets.only(
                  top: screenWidth * 0.02, bottom: screenWidth * 0.01),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.03),
                    child: SimpleAutoCompleteTextField(
                      key: GlobalKey(),
                      suggestions: [
                        "Ahmedabad",
                        "Surat",
                        "Bhavnagar",
                        "Vadodara",
                        "Rajkot",
                        "Junagadh"
                      ],
                      textChanged: (text) {},
                      clearOnSubmit: false,
                      cursorColor: kPrimaryLightColor,
                      textSubmitted: (text) {
                        setState(() {
                          selectedCityFrom = text; // Update selected city
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'From City',
                        fillColor: kPrimaryColor,
                        labelStyle: TextStyle(color: lightBlack),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  kPrimaryLightColor), // Focused border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon:
                            Icon(Icons.my_location, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.04),
                    child: SimpleAutoCompleteTextField(
                      key: GlobalKey(),
                      suggestions: [
                        "Ahmedabad",
                        "Surat",
                        "Bhavnagar",
                        "Vadodara",
                        "Rajkot",
                        "Junagadh"
                      ],
                      textChanged: (text) {},
                      clearOnSubmit: false,
                      cursorColor: kPrimaryLightColor,
                      textSubmitted: (text) {
                        setState(() {
                          selectedCityTo = text; // Update selected city
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'To City',
                        fillColor: kPrimaryColor,
                        labelStyle: TextStyle(color: lightBlack),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  kPrimaryLightColor), // Focused border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon:
                            Icon(Icons.location_on, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.04),
                    child: SimpleAutoCompleteTextField(
                      key: GlobalKey(),
                      suggestions: ["Sedan", "Xuv", "Suv"],
                      textChanged: (text) {},
                      clearOnSubmit: false,
                      cursorColor: kPrimaryLightColor,
                      style: TextStyle(color: Colors.white),
                      textSubmitted: (text) {
                        setState(() {
                          selectedCar = text; // Update selected car type
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select a Car',
                        labelStyle: TextStyle(color: lightBlack),
                        fillColor: kPrimaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color:
                                  kPrimaryLightColor), // Focused border color
                        ),
                        prefixIcon: Icon(Icons.directions_car_filled,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth * 0.04), // Adjust the padding as needed
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  primary: kPrimaryColor, // Text color
                ),
                child: Text('Cancel'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth * 0.04,
                  bottom: screenWidth * 0.01), // Adjust the padding as needed
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Apply'),
              ),
            ),
          ],
        );
      },
    );
  }
}
// MyContainer and DottedLinePainter classes remain the same

class MyContainer extends StatelessWidget {
  final String placeFrom;
  final String placeTo;
  final String carType;
  final String date;
  final String month;
  final String day;

  MyContainer({
    required this.placeFrom,
    required this.placeTo,
    required this.carType,
    required this.date,
    required this.month,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double smallfont = screenWidth * 0.03;
    double smallicon = screenWidth * 0.05;
    double mediumfont = screenWidth * 0.035;
    double largefont = screenWidth * 0.05;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.02),
      margin: EdgeInsets.only(
          left: screenWidth * 0.04,
          right: screenWidth * 0.04,
          top: screenWidth * 0.02,
          bottom: screenWidth * 0.02),
      height: screenWidth * 0.47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: kPrimaryColor, // Background color updated to black
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
            blurRadius: 1.0,
            spreadRadius: 2.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Part: Data
          Container(
            width: screenWidth * 0.3, // Set a fixed width for the left part
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.185,
                  height: screenWidth * 0.185,
                  padding: EdgeInsets.only(left: screenWidth * 0.035),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: screenWidth * 0.185,
                        color: Colors.white, // Icon color updated to yellow
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth * 0.03,
                            right: screenWidth * 0.025), // Adjust top padding
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color updated to yellow
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: screenWidth * 0.01,
                      top: screenWidth * 0.01,
                      left: screenWidth * 0.02,
                      right: screenWidth * 0.02),
                  child: Align(
                    alignment:
                        Alignment.topLeft, // Adjust the alignment as needed
                    child: Text(
                      month,
                      style: TextStyle(
                        fontSize: smallfont,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: smallicon,
                        color: kPrimaryLightColor, // Icon color
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: mediumfont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions_car,
                        size: smallicon,
                        color: kPrimaryLightColor, // Icon color
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth *
                                0.015), // Set your desired padding
                        child: Text(
                          carType,
                          style: TextStyle(
                            fontSize: mediumfont,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenWidth * 0.44,
            width: 2,
            color: Colors.grey,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          ),
          CustomPaint(
            painter: DottedLinePainter(),
            child: Container(
              height: screenWidth * 0.41,
              width: 1,
            ),
          ),
          Container(
            height: screenWidth * 0.44,
            width: 2,
            color: Colors.grey,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          ),
          SizedBox(width: screenWidth * 0.02),
          // second part
          Container(
            // Set a fixed width for the right part
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.009),
                  child: Row(
                    children: [
                      Icon(
                        Icons.my_location,
                        size: screenWidth * 0.073,
                        color: kPrimaryLightColor, // Icon color
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        placeFrom,
                        style: TextStyle(
                          fontSize: largefont,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.044),
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                    child: Container(
                      height: screenWidth * 0.075,
                      width: 1,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: screenWidth * 0.08,
                        color: kPrimaryLightColor, // Icon color
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Padding(
                        padding: EdgeInsets.only(
                            top:
                                screenWidth * 0.02), // Set your desired padding
                        child: Text(
                          placeTo,
                          style: TextStyle(
                            fontSize: largefont,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: screenWidth * 0.10,
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.01,
                      right: screenWidth * 0.01,
                      top: screenWidth * 0.00001,
                      bottom: screenWidth * 0.00001),
                  margin: EdgeInsets.only(
                      left: screenWidth * 0.02,
                      right: screenWidth * 0.02,
                      top: screenWidth * 0.03,
                      bottom: screenWidth * 0.00001),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: kPrimaryLightColor, // Set button color
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Add your logic here
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.015,
                          right:
                              screenWidth * 0.015), // Add padding to the text
                      child: Text(
                        'CONTACT NOW',
                        style: TextStyle(
                          fontSize: screenWidth * 0.038,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor, // Set text color
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kPrimaryLightColor
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 5.0;
    const double gapWidth = 3.0;
    double startX = 0.0;

    while (startX < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startX),
        Offset(size.width / 2, startX + dashWidth),
        paint,
      );
      startX += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

void main() {
  runApp(MaterialApp(
    home: Availableagent(),
  ));
}
