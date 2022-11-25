import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Controller/controller.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}


class _LoadingState extends State<Loading> {
  String temp = "Loading";
  late String hum;
  late String airsp;
  late String desc;
  late String maindes;
  late String icon;
  late String city = "Bareilly";
  void StartApp(String city) async{
    controller instance = controller(location: city);
    await instance.getData();
    temp = instance.temp;
    hum = instance.humidity;
    airsp = instance.air_speed;
    desc = instance.description;
    maindes = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, '/home',arguments: {
        "temp_val": temp,
        "hum_val": hum,
        "airsp_val":airsp,
        "desc_val":desc,
        "maindes":maindes,
        "icon_val":icon,
        "city_val":city,
      });
    });


  }
  @override
  void initState() {
    // TODO: implement initState
    // Map Search = ModalRoute.of(context)?.settings.arguments  as Map<dynamic, dynamic>;
    // if(Search?.isNotEmpty??false){
    //   city = Search['Search'];
    // }
    StartApp(city);

    super.initState();
}
  @override
  Widget build(BuildContext context) {
    Map Search = ModalRoute.of(context)?.settings.arguments  as Map<dynamic, dynamic>;
    if(Search?.isNotEmpty??false){
      city = Search['Search'];
    }
    StartApp(city);

    return SafeArea(
      child: Scaffold(
        body:Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Open Weather",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
              SizedBox(height: 40),
              Image.asset('assets/weatherlogo.png',height: 100,width: 80,),
              SizedBox(height: 60),
              SpinKitWave(
                color: Colors.white,
                size: 50.0,
              ),
              SizedBox(height: 70,),
              Text("Developed by Aman",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),

            ],
          )
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
