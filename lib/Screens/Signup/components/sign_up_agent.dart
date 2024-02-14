import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_field/image_field.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../../Screens/Otp/otpscreen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController aadharCardNumberController = TextEditingController();
  TextEditingController drivingLicenseNumberController =
      TextEditingController();
  List<ImageAndCaptionModel>? aadharCardPhotos = [];
  List<ImageAndCaptionModel>? drivingLicensePhotos = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Aadhar Card Number field
          TextFormField(
            controller: aadharCardNumberController,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: InputDecoration(
              hintText: "Aadhar Card Number",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.credit_card),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Upload for Aadhar Card using ImageField
          ImageField(
            onSave: (List<ImageAndCaptionModel>? imageAndCaptionList) {
              setState(() {
                aadharCardPhotos = imageAndCaptionList;
              });
            },
          ),
          // Display selected Aadhar card photos
          if (aadharCardPhotos != null)
            Column(
              children: aadharCardPhotos!.map((image) {
                return Image.file(
                  File(image.file.path),
                  width: 100,
                  height: 100,
                );
              }).toList(),
            ),
          const SizedBox(height: defaultPadding),

          // Driving License Number field

          // Upload for Driving License using ImageField
          ImageField(
            onSave: (List<ImageAndCaptionModel>? imageAndCaptionList) {
              setState(() {
                drivingLicensePhotos = imageAndCaptionList;
              });
            },
          ),
          // Display selected Driving License photos
          if (drivingLicensePhotos != null)
            Column(
              children: drivingLicensePhotos!.map((image) {
                return Image.file(
                  File(image.file.path),
                  width: 100,
                  height: 100,
                );
              }).toList(),
            ),
          const SizedBox(height: defaultPadding),
          Text(
            'Upload front and back side of Aadhar Card',
            style: TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              // Implement your signup logic here
              // String aadharCardNumber = aadharCardNumberController.text;
              // String drivingLicenseNumber = drivingLicenseNumberController.text;
              // Use aadharCardPhotos and drivingLicensePhotos for photo files
              // Perform signup logic with the collected data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OtpScreen(); // Replace with your actual class name
                  },
                ),
              );
            },
            child: Text("Next".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),

          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
