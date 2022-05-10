import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:weather_api_app/screens/change-city.dart';

class NewLocationTemperatureScreen extends StatefulWidget {
  final String cityValue;
  const NewLocationTemperatureScreen({Key? key, required this.cityValue})
      : super(key: key);

  @override
  State<NewLocationTemperatureScreen> createState() =>
      _NewLocationTemperatureScreenState();
}

class _NewLocationTemperatureScreenState
    extends State<NewLocationTemperatureScreen> {
  var _locations;
  var realTemp;
  var cityName;

  getNewTemperature(cityName) {
    http
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
      print(temp);
      print(temp["main"]["temp"]);
      var temp2 = temp["main"]["temp"];
      var temp3 = temp2;

      print(temp3);

      setState(() {
        realTemp = temp3;
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
      appBar: AppBar(),
      body: Column(
        children: [
          Text(realTemp.toString()),
          TextButton(
            onPressed: () {
              getNewTemperature(realTemp);
            },
            child: Text("Get my current weather temperature"),
          ),
          TextButton(
            onPressed: () {
              Get.to(ChangeCityScreen());
            },
            child: Text("Change city"),
          ),
        ],
      ),
    );
  }
}
