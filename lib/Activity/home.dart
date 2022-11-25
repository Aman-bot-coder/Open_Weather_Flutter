import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/Controller/controller.dart';
// import 'package:weather_icons/weather_icons.dart';
import 'package:dynamic_weather_icons/dynamic_weather_icons.dart';

// import 'package:flutter_weather_icons/flutter_weather_icons.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Bareilly",
      "Moradabad",
      "Delhi",
      "Mumbai",
      "Pune",
      "Noida"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = ModalRoute.of(context)?.settings.arguments  as Map<dynamic, dynamic>;
    String tempp =((info['temp_val']).toString());
    String airs = ((info['airsp_val'].toString()));
    if(tempp=="N/A"){
      print("Wrong Search");
    }else{
       tempp =((info['temp_val']).toString().substring(0,4));
       airs = ((info['airsp_val'].toString().substring(0,3)));
      
    }
    
    String icon = info['icon_val'];
    String getCity = info['city_val'];
    String hum = info['hum_val'];
   
    String des = info['desc_val'];
    TextEditingController SearchCon = new TextEditingController();
    return Scaffold(
    resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.blue,
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Colors.pink,
                  Colors.blue,
                  Colors.lightBlue,
                ],
              )),
              child: Column(
                children: [
                  Container(
                    //Search  Container
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if((SearchCon.text.replaceAll(" ", ""))==""){
                              print("Please Enter Valid City");
                            }else{
                              Navigator.pushReplacementNamed(context, "/loading",arguments: {
                                "Search":SearchCon.text
                              });}

                          },
                          child: Container(
                            child: const Icon(Icons.search),
                            margin: const EdgeInsets.fromLTRB(3, 0, 9, 0),
                          ),
                        ),
                        Expanded(
                            child: TextField(
                              controller: SearchCon,
                          decoration: InputDecoration(
                            hintText: "Search $city",
                            border: InputBorder.none,
                          ),
                        )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          padding: const EdgeInsets.all(26),
                          child: Row(
                            children: [
                              Image.network("http://openweathermap.org/img/wn/$icon@2x.png"),
                              SizedBox(width: 10,),
                              Column(
                                children:  [

                                  Text(
                                    "$des",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text("In $getCity",style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin:
                              const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          padding: const EdgeInsets.all(26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              const Icon(CupertinoIcons.thermometer),
                              SizedBox(height: 40,),
                              Text("Temperature",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [

                                  Text("$tempp",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 80),
                                  ),

                                  Text("°C",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),
                                  ),


                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: const EdgeInsets.all(26),
                          child: Column(
                            children: [
                              Text("Air Speed",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,),),
                              Row(

                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(CupertinoIcons.wind),
                                ],
                              ),
                              Text("$airs km/h",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: const EdgeInsets.all(26),
                          child: Column(

                            children: [
                              Text("Humidity",style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold,),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(CupertinoIcons.drop_fill),
                                ],
                              ),
                              Text("$hum %",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "VenusAppLab",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
