import 'package:flexigadi/Screens/Signup/signup_screen_agent.dart';

import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class AgentDetailsForm extends StatefulWidget {
  const AgentDetailsForm({Key? key}) : super(key: key);

  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<AgentDetailsForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  String? _selectedGender;

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();

  DateTime? _selectedDate;

  final Map<String, Color> _genderColors = {
    'Male': kPrimaryLightColor,
    'Female': kPrimaryLightColor,
    'Other': kPrimaryLightColor,
  };

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _cityController.dispose();

    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _dobFocus.dispose();
    _cityFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardDismisser(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35, top: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      'PERSONAL DETAILS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor, // Font color
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _firstNameController,
                  focusNode: _firstNameFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  cursorColor: kPrimaryLightColor,
                  onChanged: (_) => _callFocusChange(),
                  style: TextStyle(color: Colors.white), // Font color
                  onEditingComplete: () => _lastNameFocus.requestFocus(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  focusNode: _lastNameFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  cursorColor: kPrimaryLightColor,
                  onChanged: (_) => _callFocusChange(),
                  style: TextStyle(color: Colors.white), // Font color
                  onEditingComplete: () => _dobFocus.requestFocus(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dobController,
                  focusNode: _dobFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Date of Birth',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  cursorColor: kPrimaryLightColor,
                  onTap: () => _selectDate(context),
                  readOnly: true,
                  style: TextStyle(
                    color: _selectedDate != null
                        ? kPrimaryLightColor
                        : Colors.white, // Font color
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  focusNode: _cityFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'City',
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  cursorColor: kPrimaryLightColor,
                  onChanged: (_) => _callFocusChange(),
                  style: TextStyle(color: Colors.white), // Font color
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                    _callFocusChange();
                  },
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem<String>(
                            value: gender,
                            child: Text(
                              gender,
                              style: TextStyle(
                                color: _genderColors[gender],
                              ),
                            ),
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    hintText: 'Gender',
                    prefixIcon: Icon(Icons.people),
                  ),
                  style: TextStyle(color: kPrimaryColor), // Font color
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpagentScreen();
                        },
                      ),
                    );
                    // Implement form submission logic here
                  },
                  child: Text('NEXT'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Colors.black),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void _callFocusChange() {
    // ignore: unused_local_variable
    bool hasFocus = _firstNameFocus.hasFocus ||
        _lastNameFocus.hasFocus ||
        _dobFocus.hasFocus ||
        _cityFocus.hasFocus;
    // Implement any focus change logic here
  }
}
