import 'package:flutter/material.dart';

class WaterTax extends StatefulWidget {
  const WaterTax({Key? key}) : super(key: key);

  @override
  _WaterTaxState createState() => _WaterTaxState();
}

class _WaterTaxState extends State<WaterTax> {
  String img = "assets/images/logowater.png";
  String rs = '';
  var ctype=null;
  TextEditingController are = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Tax"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Card(
          elevation: 0,
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(img),
                  ),
                ),
              ),
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                width: 300,
                child: Text("WaterTax:$rs", style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: are,
                  decoration: InputDecoration(
                    hintText: "Enter the area of home in /squarefeet",
                    labelText: "Area",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 30,),
              Container(
                alignment: Alignment.center,
                width: 300,
                child: DropdownButton<String>(
                  value: ctype,
                  items: [
                    DropdownMenuItem(child: Text("Regular"),
                    value: "R",),
                    DropdownMenuItem(child: Text("Commercial"),
                      value: "C",),

                  ],
                  hint: Text("Select Home Type"),
                  onChanged: (value){
                    setState(() {
                      ctype=value;
                      print(ctype);
                    });
                  },
                ),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: BorderSide(color: Colors.yellow)
                              ))
                      ),
                      onPressed: Calculate,
                      child: Text("Calculate"),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: BorderSide(color: Colors.yellow)
                              ))
                      ),
                      onPressed: clearText,
                      child: Text("Clear"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),


    );
  }

  void Calculate() {
    double amount = 0;
    if (are.text == '' || (ctype != "R" && ctype != 'C')) {
      showAlertDialog(context);
      setState(() {
        rs = '';
      });
    } else {
      int unit = int.parse(are.text.toString());
      if (ctype == 'R') {
        if (unit <= 700)
          amount = unit * 20.5;
        else if (unit <= 2000)
          amount = (700 * 20.5) + (unit - 700) * 27.5;
        else if (unit <= 10000)
          amount = (700 * 20.5) + (1300 * 27.5) + (unit - 2000) * 80.4;
        else
          amount = (700 * 20.5) + (1300 * 27.5)+ (8000 * 80.4) + (unit - 10000) * 90.40;
      } else if (ctype == 'C') {
        if (unit <= 700)
          amount = unit * 40.80;
        else if (unit <= 2000)
          amount = (700 * 40.80) + (unit - 700) * 56.17;
        else if (unit <= 10000)
          amount = (700 * 40.80) + (1300 * 56.17) + (unit - 2000) * 103.18;
        else
          amount = (700 * 40.80) + (1300 * 56.17)+ (8000 * 103.18) + (unit - 10000) * 202.18;
      }
      setState(() {
        print(amount);
        rs = amount.toStringAsFixed(2);
      });
    }
  }
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Error!"),
      content: Text("Empty number of units or Invalid connection type."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void clearText() {
    are.clear();
  }
}

