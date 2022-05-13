import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:get/get.dart';
import 'package:weather_api_app/screens/new-location-temperature.dart';

class ChangeCityScreen extends StatefulWidget {
  ChangeCityScreen({Key? key}) : super(key: key);

  @override
  State<ChangeCityScreen> createState() => _ChangeCityScreenState();
}

class _ChangeCityScreenState extends State<ChangeCityScreen> {
  String cityValue = "";
  String countryValue = "";
  String stateValue = "";
  String address = "";
  GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select a new location "),
        backgroundColor: Colors.green.shade900,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),

            ///Adding CSC Picker Widget in app
            CSCPicker(
              showStates: true,
              showCities: true,
              flagState: CountryFlag.ENABLE,
              dropdownDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white,
              ),

              ///labels for dropdown
              countryDropdownLabel: " Country",
              stateDropdownLabel: "State",
              cityDropdownLabel: "City",

              dropdownDialogRadius: 10.0,
              searchBarRadius: 10.0,
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value.toString();
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value.toString();
                  //print(cityValue);
                });
              },
            ),

            ///print newly selected country state and city in Text Widget
            TextButton(
                onPressed: () {
                  setState(() {
                    address = "$cityValue, $stateValue, $countryValue";
                  });
                },
                child: Text("Confirm selection", style: TextStyle(color: Colors.blue.shade900),)),
            TextButton(
                onPressed: () {
                  setState(() {
                    address = "$cityValue, $stateValue, $countryValue";
                  });
                  Get.offAll(NewLocationTemperatureScreen(
                    cityValue: cityValue,
                  ));
                },
                child: Text("See new location's weather", style: TextStyle(color: Colors.orange.shade900),)),
            Text(address)
          ],
        ),
      ),
    );
  }
}
