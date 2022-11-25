
import 'dart:convert';

import 'package:http/http.dart';
class controller{
  late String location;

  controller({required this.location}){
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;
  Future<void> getData() async {
    try{
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=281bb84a8cbe41d10fbde335e9427514"));
      Map data = jsonDecode(response.body);


      //  Getting temp , humdity

      Map temp_data = data['main'];
      double temp_weather = temp_data['temp']-273.15;
      String getHumidity = temp_data['humidity'].toString();


      //  air
      Map wind = data['wind'];
      double getAir_speed = wind['speed']*3.6;






      //  Description


      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String main_des = weather_main_data['main'];
      String getdesc = weather_main_data['description'];
      String iconss = weather_main_data['icon'];
      print(iconss);



      //Assigning values
      temp = temp_weather.toString();
      humidity = getHumidity;
      air_speed = getAir_speed.toString();
      description = getdesc;
      main = main_des;
      icon = iconss.toString();

    }catch(e){
      temp = "N/A";
      humidity = "N/A";
      air_speed = "N/A";
      description = "Some Error!!";
      main = "Some Error!!";
      icon = "01d";
    }




  }


}