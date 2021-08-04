import 'package:flutter/material.dart';
class MyElectricityBill extends StatefulWidget {
  const MyElectricityBill({Key? key}) : super(key: key);

  @override
  _MyElectricityBillState createState() => _MyElectricityBillState();
}

class _MyElectricityBillState extends State<MyElectricityBill> {
  String img = "assets/images/logo.jpg";
  String rs = '';
  TextEditingController unit = new TextEditingController();
   var ctype=null;
  TextEditingController u = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Electricty Bill"),
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
                child: Text("Amount:$rs", style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: u,
                  decoration: InputDecoration(
                    hintText: "Enter no of unit",
                    labelText: "Units",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 30,),
              Container(
                alignment: Alignment.center,
                width: 300,
                child: DropdownButton<String>(
                  //elevation: 5,
                  dropdownColor: Colors.orange,
                  //icon: Icon(Icons.arrow_downward),
                  value: ctype,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  items: <String>["Domestic",'Commercial',
                    // DropdownMenuItem(
                    //   child: Text("Select Connection Type"),
                    //   value: "Select Connection Type",
                    // ),
                    // DropdownMenuItem(
                    //   child: Text("Domestic"),
                    //   value: "D",
                    // ),
                    // DropdownMenuItem(
                    //   child: Text("Commercial"),
                    //   value: "C",
                    // ),
                  ].map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>
                      (child: Text(value,style: TextStyle(),),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (String ? value) {
                    setState(() {
                      ctype = value!;
                      print(ctype);
                      //Calculate();
                    });
                  },
                hint: Text("Select"),),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
    double amount=0;
    if(u.text==''||(ctype!="Domestic"&&ctype!='Commercial')) {
      showAlertDialog(context);
      setState(() {
        rs = u.text;
      });
    } else {
      int unit=int.parse(u.text.toString());
      if(unit<=80)
        amount=650;
      else
      if(ctype=='Domestic'){
        if(unit<=100)
          amount=unit*4.20;
        else if(unit<=350)
          amount=(100*4.20)+(unit-100)*7.40;
        else if(unit<=804)
          amount=(100*4.20)+(250*7.40)+(unit-350)*9.20;
        else
          amount=(100*4.20)+(250*7.40)+(453*9.20)+(unit-804)*10.80;
      }else
      if(ctype=='Commercial'){
        if(unit<=100)
          amount=unit*8.90;
        else if(unit<=350)
          amount=(100*8.90)+(unit-100)*10.80;
        else if(unit<=804)
          amount=(100*8.90)+(250*10.80)+(unit-350)*12.70;
        else
          amount=(100*8.90)+(250*10.80)+(453*12.70)+(unit-804)*16.40;
      }
      setState(() {
        print(amount);
        amount+=60;
        rs=amount.toString();
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
  void clearText(){
    u.clear();
  }
}
