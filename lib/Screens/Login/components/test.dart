import 'package:flutter/material.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
// ignore: duplicate_import
import '../../../Screens/Driver/Screens/Home/screens/homescreen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
          const SizedBox(height: defaultPadding), // Spacer

          // Mobile number field instead of email
          TextFormField(
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryLightColor,
            onSaved: (mobileNumber) {
              // Save the mobile number value
            },
            decoration: InputDecoration(
              hintText: "Your mobile number",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              textInputAction: TextInputAction.done,
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
          const SizedBox(height: defaultPadding),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomedriverScreen();
                  },
                ),
              );

              // Implement your login logic here
            },
            child: Text("Login".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
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
