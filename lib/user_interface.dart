import 'package:flutter/material.dart';
import 'result_screeen.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class UserInterface extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserInterfaceState();
  }
}

class UserInterfaceState extends State<UserInterface> {
  final TextEditingController _ageController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();

  var _dropList;
  var _dropDown;

  /* Formula: weight (lb) / [height (in)]2 x 703
      Calculation: [weight (lb) / height (in) / height (in)] x 703
      Source:https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_2.html
    */

  navigate() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ResultScreen(
                help: heightController.text,
                hope: weightController.text,
              )),
    );
  }

  _clear() {
    setState(() {
      weightController.clear();
      heightController.clear();
      _ageController.clear();
      _sexController.clear();
      _dropList = null;

      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  @override
  void initState() {
    _dropDown = ButtonTheme(
      child: DropdownButton<String>(
        isDense: true,
        iconSize: 30.0,
        items: <String>['Male', 'Female'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(growable: false),
        onChanged: (value) {
          _dropList = value;
          setState(() {});
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("BMI Calculator"),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            Image.asset(
              "images/bmilogo.png",
              fit: BoxFit.scaleDown,
              height: 100.0,
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(1.0),
              alignment: Alignment.center,
              color: Colors.grey.shade200,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextField(
                      style: TextStyle(fontSize: 19.0, color: Colors.black),
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Please enter your age",
                          hintText: "in years",
                          icon: Icon(Icons.person_outline)),
                    ),
                    TextField(
                      style: TextStyle(fontSize: 19.0, color: Colors.black),
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Please enter your height",
                          hintText: "in inches",
                          icon: Icon(Icons.photo_size_select_actual)),
                    ),
                    TextField(
                      style: TextStyle(fontSize: 19.0, color: Colors.black),
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Please enter your weight",
                          hintText: "in pounds",
                          icon: Icon(Icons.line_weight)),
                    ),
                    TextField(
                      focusNode: AlwaysDisabledFocusNode(),
                      style: TextStyle(fontSize: 19.0, color: Colors.black),
                      decoration: InputDecoration(
                          labelText: _dropList == null
                              ? "Please choose your sex"
                              : "$_dropList.",
                          icon: Icon(Icons.people),
                          suffixIcon: _dropDown),
                    ),
                    Padding(padding: EdgeInsets.all(4.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          textColor: Colors.white,
                          color: Colors.pinkAccent,
                          splashColor: Colors.deepPurpleAccent,
                          highlightColor: Colors.pinkAccent,
                          elevation: 3.0,
                          onPressed: navigate,
                          child: Text("Calculate"),
                        ),
                        RaisedButton(
                          textColor: Colors.white,
                          color: Colors.pinkAccent,
                          splashColor: Colors.deepPurpleAccent,
                          highlightColor: Colors.pinkAccent,
                          elevation: 3.0,
                          onPressed: _clear,
                          child: Text("Clear"),
                        )
                      ],
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
