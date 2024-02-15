import 'package:flexigadi/Screens/Customer/screen/Profile/components/contact.dart';
import 'package:flexigadi/Screens/Driver/Screens/Profile/components/personal.dart';
import 'package:flutter/material.dart';
import '../../../../../constants.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenWidth * 0.2),
              child: Container(
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
                      'assets/images/driver.jpg', // Replace with your image path
                      fit: BoxFit.cover,
                      width: screenWidth * 0.45,
                      height: screenWidth * 0.45,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.04),
            _buildProfileOption(context, 'Personal Details', Icons.person),
            _buildProfileOption(
                context, 'Terms & Conditions', Icons.assignment),
            _buildProfileOption(context, 'Refer & Earn', Icons.share),
            _buildProfileOption(context, 'Contact Us', Icons.support_agent),
            _buildProfileOption(context, 'Settings', Icons.settings),
            _buildProfileOption(context, 'Logout', Icons.logout),
            SizedBox(height: screenWidth * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      BuildContext context, String title, IconData icon) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        // Handle option tap
        switch (title) {
          case 'Personal Details':
            // Navigate to Personal Details screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DriverDetailsScreen()),
            );
            break;
          case 'Terms & Conditions':
            // Navigate to Terms & Conditions screen

            break;
          case 'Refer & Earn':
            // Navigate to Refer & Earn screen
            break;
          case 'Contact Us':
            // Navigate to Settings screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactScreen()),
            );
            break;
          case 'Settings':
            // Navigate to Settings screen
            break;
          case 'Logout':
            // Perform logout action
            break;
          default:
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.07, vertical: screenWidth * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(width: screenWidth * 0.05),
            Text(
              title,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}
