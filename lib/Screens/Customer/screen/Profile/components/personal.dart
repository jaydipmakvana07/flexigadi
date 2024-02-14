import 'package:flutter/material.dart';
import '../../../../../constants.dart';

class DriverDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: screenWidth * 0.05,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenWidth * 0.5,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 107, 105, 105),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/driver_02.jpg', // Replace with your image path
                      fit: BoxFit.cover,
                      width: screenWidth * 0.45,
                      height: screenWidth * 0.45,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BoxWidget(
                    title: 'Completed',
                    value: '100',
                    icon: Icons.directions_car,
                    backgroundColor: kPrimaryColor, // Example color
                    textColor: Colors.white,
                    // Example value
                  ),
                  BoxWidget(
                    title: 'Ratings',
                    value: '4.5',
                    icon: Icons.star,
                    backgroundColor: kPrimaryLightColor, // Example color
                    textColor: Colors.white, // Example value
                  ),
                  BoxWidget(
                    title: 'Verified',
                    value: 'Yes',
                    icon: Icons.check_circle,
                    backgroundColor: Colors.green, // Example color
                    textColor: Colors.white, // Example value
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.06),
              DetailsWidget(
                title: 'Driver Name',
                value: 'Keyur Parmar', // Example value
              ),
              DetailsWidget(
                title: 'Mobile Number',
                value: '9876543210', // Example value
              ),
              DetailsWidget(
                title: 'DOB',
                value: '01-05-1998', // Example value
              ),
              DetailsWidget(
                title: 'Aadhar Number',
                value: '1234 5678 9012', // Example value
              ),
              DetailsWidget(
                title: 'License Number',
                value: 'ABCD123456', // Example value
              ),
              DetailsWidget(
                title: 'City',
                value: 'Surat', // Example value
              ),
              DetailsWidget(
                title: 'Cars',
                value: 'Ertiga, Dzire, Innova', // Example value
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;

  const BoxWidget({
    required this.title,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: screenWidth * 0.055,
          right: screenWidth * 0.06,
          top: screenWidth * 0.02,
          bottom: screenWidth * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        color: backgroundColor,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: textColor,
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
              Icon(
                icon,
                color: textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final String title;
  final String value;

  const DetailsWidget({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, vertical: screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
