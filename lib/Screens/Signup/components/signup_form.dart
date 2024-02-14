import 'package:flexigadi/Screens/Signup/agent_detail.dart';
import 'package:flexigadi/Screens/Signup/driver_detail.dart';
import 'package:flutter/material.dart';
import 'package:flexigadi/constants.dart';
import '../../Login/login_screen.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../signup_detail.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final List<String> dropdownOptions = ['CUSTOMER', 'AGENT', 'DRIVER'];
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          // Dropdown menu as the first form field
          DropdownButtonFormField<String>(
            value: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
            items: dropdownOptions
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(color: kPrimaryLightColor),
                      ),
                    ))
                .toList(),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding,
              ),
              labelText: selectedOption != null ? null : 'Select an option',
              labelStyle: TextStyle(color: lightBlack),
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.car_rental),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2), // Spacer

          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 5),
            // Mobile number field instead of password
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your mobile number",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 5),
            // Password field
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              textInputAction: TextInputAction.next,
              obscureText: true,
              cursorColor: kPrimaryLightColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 5),
            // Confirm Password field
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryLightColor,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          ElevatedButton(
            onPressed: () {
              // Implement your signup logic here
              if (selectedOption == 'DRIVER') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return DriverDetailsForm();
                    },
                  ),
                );
              } else if (selectedOption == 'CUSTOMER') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserDetailsForm();
                    },
                  ),
                );
              } else if (selectedOption == 'AGENT') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AgentDetailsForm();
                    },
                  ),
                );
              }
            },
            child: Text("NEXT".toUpperCase()),
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
