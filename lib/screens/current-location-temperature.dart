import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_api_app/screens/change-city.dart';
import 'dart:convert';


class CurrentLocationTemperatureScreen extends StatefulWidget {
  const CurrentLocationTemperatureScreen({Key? key}) : super(key: key);

  @override
  State<CurrentLocationTemperatureScreen> createState() => _CurrentLocationTemperatureScreenState();
}

class _CurrentLocationTemperatureScreenState extends State<CurrentLocationTemperatureScreen> {
  @override
  void initState() {
    // TODO: implement initState
    this.findMyLocation();
    //this.getAds();
    super.initState();
  }
  

  var lat = 0.0;
  var lng = 0.0;
  var _locations;
  var realTemp;
  
  
  

  findMyLocation() async {
    bool devicePermission;
    devicePermission = await Geolocator.isLocationServiceEnabled();
    if (devicePermission) {
      var appLevel = await Geolocator.checkPermission();
      if (appLevel == LocationPermission.denied) {
        appLevel = await Geolocator.requestPermission();
      } else if (appLevel == LocationPermission.deniedForever) {
        print("Error: App location permission denied forever");
      }
      var location = await Geolocator.getCurrentPosition();
      print(location.accuracy);
      setState(() {
        lat = location.latitude;
        lng = location.longitude;
      });
      getTemperature(lat, lng);
    } else {
      print("Error : GPS sensor permission issue, device level");
    }
  }

  getTemperature(lat, lng) {
    http
        //.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
        .get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=c9fd50292a6281c5b90c99ee4418f8d5&units=metric"))
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
      var temp3 = temp2 ; 
      
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
              findMyLocation();
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
