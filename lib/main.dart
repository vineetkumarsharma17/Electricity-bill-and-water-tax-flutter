import 'package:bill_calculator/pages/drawer.dart';
import 'package:bill_calculator/pages/electricity.dart';
import 'package:bill_calculator/pages/watertax.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Homepage() ,
      routes: {
        "/electric":(context)=>MyElectricityBill(),
        '/water':(context)=>WaterTax(),
      },
    );
  }
}
class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Calculation"),
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            padding: EdgeInsets.all(20),
            //color: Colors.red,
            child: Text("Bill Calculator",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 29,
            ),),
          ),
          SizedBox(height: 150,),
          Container(
            height: 40,
            width: 150,
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context)=>MyElectricityBill(),
                  ));
                },
                child: Text("Electricity Bill",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),)),
          ),
          SizedBox(height: 20,),
          Container(
            height: 40,
            width: 150,
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context)=>WaterTax(),
                      ));
                },
                child: Text("Water Tax",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ))),
          ),
        ],
      ),
      ),
      drawer: MyDrawer(),

    );
  }
}



