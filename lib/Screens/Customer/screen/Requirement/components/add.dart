import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../../../constants.dart';

class CabBookingForm extends StatefulWidget {
  final Function(bool) onFocusChange;

  CabBookingForm({Key? key, required this.onFocusChange}) : super(key: key);

  @override
  _CabBookingFormState createState() => _CabBookingFormState();
}

class _CabBookingFormState extends State<CabBookingForm> {
  TextEditingController fromCityController = TextEditingController();
  TextEditingController toCityController = TextEditingController();
  TextEditingController travelDateController = TextEditingController();
  TextEditingController carTypeController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController tripTypeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  late FocusNode fromCityFocusNode;
  late FocusNode toCityFocusNode;
  late FocusNode travelDateFocusNode;
  late FocusNode carTypeFocusNode;
  late FocusNode dayFocusNode;
  late FocusNode tripTypeFocusNode;
  late FocusNode noteFocusNode;

  @override
  void initState() {
    super.initState();

    fromCityFocusNode = FocusNode();
    toCityFocusNode = FocusNode();
    travelDateFocusNode = FocusNode();
    carTypeFocusNode = FocusNode();
    dayFocusNode = FocusNode();
    tripTypeFocusNode = FocusNode();
    noteFocusNode = FocusNode();
  }

  @override
  void dispose() {
    fromCityFocusNode.dispose();
    toCityFocusNode.dispose();
    travelDateFocusNode.dispose();
    carTypeFocusNode.dispose();
    dayFocusNode.dispose();
    tripTypeFocusNode.dispose();
    noteFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    bool hasFocus = fromCityFocusNode.hasFocus ||
        toCityFocusNode.hasFocus ||
        travelDateFocusNode.hasFocus ||
        carTypeFocusNode.hasFocus ||
        dayFocusNode.hasFocus ||
        tripTypeFocusNode.hasFocus ||
        noteFocusNode.hasFocus;

    widget.onFocusChange(hasFocus);
  }

  void submitForm() {
    print('From City: ${fromCityController.text}');
    print('To City: ${toCityController.text}');
    print('Travel Date: ${travelDateController.text}');
    print('Car Type: ${carTypeController.text}');
    print('Day: ${dayController.text}');
    // Implement your logic for form submission
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white, Colors.white, Colors.white],
            stops: [0, 0.3, 0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: KeyboardDismisser(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 25, right: 25, bottom: 30),
              margin: const EdgeInsets.only(
                  top: 40.0, left: 30, right: 30, bottom: 20),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SimpleAutoCompleteTextField(
                      key: GlobalKey(),
                      controller: fromCityController,
                      focusNode: fromCityFocusNode,
                      suggestions: ["Ahmedabad", "Surat", "Bhavnagar"],
                      textChanged: (text) {},
                      clearOnSubmit: false,
                      cursorColor: kPrimaryLightColor,
                      textSubmitted: (text) {},
                      decoration: InputDecoration(
                        labelText: 'From City',
                        fillColor: Colors.white,
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
                            Icon(Icons.my_location, color: kPrimaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SimpleAutoCompleteTextField(
                      key: GlobalKey(),
                      controller: toCityController,
                      focusNode: toCityFocusNode,
                      suggestions: ["Ahmedabad", "Surat", "Bhavnagar"],
                      textChanged: (text) {},
                      clearOnSubmit: false,
                      cursorColor: kPrimaryLightColor,
                      textSubmitted: (text) {},
                      decoration: InputDecoration(
                        labelText: 'To City',
                        fillColor: Colors.white,
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
                        prefixIcon:
                            Icon(Icons.location_on, color: kPrimaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextField(
                      controller: travelDateController,
                      focusNode: travelDateFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Travel Date',
                        fillColor: Colors.white,
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
                            Icon(Icons.date_range, color: kPrimaryColor),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                // Set your desired color here
                                colorScheme: ColorScheme.light(
                                    primary: Color.fromARGB(255, 0, 0, 0)),
                                buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary),
                                highlightColor: Color.fromARGB(255, 13, 4, 0),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          travelDateController.text =
                              pickedDate.toLocal().toString().split(' ')[0];
                        }
                        _handleFocusChange();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextField(
                      controller: dayController,
                      focusNode: dayFocusNode,
                      cursorColor: kPrimaryLightColor,
                      decoration: InputDecoration(
                        labelText: 'Day',
                        fillColor: Colors.white,
                        focusColor: Colors.white,
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
                            Icon(Icons.access_time, color: kPrimaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SimpleAutoCompleteTextField(
                      key: GlobalKey(),
                      controller: carTypeController,
                      focusNode: carTypeFocusNode,
                      suggestions: ["Sedan", "SUV", "Ertiga"],
                      textChanged: (text) {},
                      cursorColor: kPrimaryLightColor,
                      clearOnSubmit: false,
                      textSubmitted: (text) {},
                      decoration: InputDecoration(
                        labelText: 'Select Car',
                        fillColor: Colors.white,
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
                            Icon(Icons.car_rental, color: kPrimaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SimpleAutoCompleteTextField(
                      key: GlobalKey(),
                      controller: tripTypeController,
                      focusNode: tripTypeFocusNode,
                      suggestions: ["One Way Trip", "Round Trip"],
                      textChanged: (text) {},
                      clearOnSubmit: false,
                      cursorColor: kPrimaryLightColor,
                      textSubmitted: (text) {},
                      decoration: InputDecoration(
                        labelText: 'Trip Type',
                        fillColor: Colors.white,
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
                        prefixIcon: Icon(Icons.repeat, color: kPrimaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: TextField(
                      controller: noteController,
                      focusNode: noteFocusNode,
                      cursorColor: kPrimaryLightColor,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        fillColor: Colors.white,
                        focusColor: Colors.white,
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
                            Icon(Icons.event_note, color: kPrimaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: ElevatedButton(
                      onPressed: submitForm,
                      child: Text(
                        'Add Now',
                        style: TextStyle(
                          fontSize: 18, // Adjust the font size as needed
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryLightColor,
                        onPrimary: kPrimaryColor, // Change the color as needed
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
