import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:weather_api_app/screens/change-city.dart';

class NewLocationTemperatureScreen extends StatefulWidget {
  NewLocationTemperatureScreen({Key? key, required this.cityValue})
      : super(key: key);
  String cityValue;

  @override
  State<NewLocationTemperatureScreen> createState() =>
      _NewLocationTemperatureScreenState();
}

class _NewLocationTemperatureScreenState
    extends State<NewLocationTemperatureScreen> {
  var _locations;
  var realTemp;
  var currentCity;
  var currentCountry;
  var currentLat;
  var currentLong;
  var currentFeelsLike;
  // final String cityName = cityValue;
  @override
  void initState() {
    // TODO: implement initState

    getNewTemperature();
    //print(city);
    super.initState();
  }

  getNewTemperature() async {
    //print(cityValue);
        var cityName = widget.cityValue;

    await http
        //.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
        .get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=c9fd50292a6281c5b90c99ee4418f8d5&units=metric"))
        .then((resp) {
      // print("Responce happened, then executed");
      // print(res.body);
      //print(json.decode(resp.body));
      var temp = json.decode(resp.body);
      setState(() {
        _locations = temp;
      });
      //print(temp);
      //print(temp["main"]["temp"]);
      var temp2 = temp["main"]["temp"];
      var temp3 = temp2;
      var temp4 = temp["name"]; // currrent city
      var temp5 = temp["sys"]["country"]; // current country
      var temp6 = temp["coord"]["lon"]; //current longitud
      var temp7 = temp["coord"]["lat"]; // current latitude
      var temp8 = temp["main"]["feels_like"];
      //print(temp["name"]);

      //print(temp3);

      setState(() {
        realTemp = temp3;
        currentCity = temp4;
        currentCountry = temp5;
        currentLong = temp6;
        currentLat = temp7;
        currentFeelsLike = temp8;
      });

      //print(_locations['id']);
    }).catchError((err) {
      print("Error happened, catch executed");
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current  weather"),
        backgroundColor: Colors.green.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("Current temperature:  " + realTemp.toString()),
              SizedBox(
                height: 20,
              ),
               Text("Feels like:  " + currentFeelsLike.toString()),
              SizedBox(
                height: 20,
              ),
              Text("City:  " + currentCity.toString()),
              SizedBox(
                height: 20,
              ),
              Text("Country:  " + currentCountry.toString()),
              SizedBox(
                height: 20,
              ),
              Text("Your current longitude:  " + currentLong.toString()),
              SizedBox(
                height: 20,
              ),
              Text("Your current latitude:  " + currentLat.toString()),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  getNewTemperature();
                },
                child: Text(
                  "Refresh ",
                  style: TextStyle(color: Colors.orange.shade900),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(ChangeCityScreen());
                },
                child: Text(
                  "Change city",
                  style: TextStyle(color: Colors.blue.shade900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
