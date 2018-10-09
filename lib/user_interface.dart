import 'package:flutter/material.dart';
import 'calculations.dart';

class UserInterface extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserInterfaceState();
  }
}

class UserInterfaceState extends State<UserInterface> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _weight;
  String _height;
  double _result = 0.0;

  /* Formula: weight (lb) / [height (in)]2 x 703
      Calculation: [weight (lb) / height (in) / height (in)] x 703
      Source:https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_2.html
    */

  _clear() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _ageController.clear();
      _result = 0.0;

      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  void _displayBMI(String weight, String height, int multiplier) {
    setState(() {
      height = _heightController.text;
      weight = _weightController.text;

      _result = calculateBMI(height, weight, multiplier);

      FocusScope.of(context).requestFocus(new FocusNode());

      if (_result <= 18.5) {
        final _snackBar = SnackBar(
          content: Text('You are Underweight'),
          backgroundColor: Colors.grey.shade200,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'OK',
            onPressed: _okPressed,
          ),
        );

        _scaffoldKey.currentState.showSnackBar(_snackBar);
      }

      if (_result > 18.5 && _result <= 24.5) {
        final _snackBar = SnackBar(
          content: Text('You are a Normalweight'),
          backgroundColor: Colors.pink,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'OK',
            onPressed: _okPressed,
          ),
        );

        _scaffoldKey.currentState.showSnackBar(_snackBar);
      }

      if (_result >= 25.0 && _result <= 29.9) {
        final _snackBar = SnackBar(
          content: Text('You are Overweight'),
          backgroundColor: Colors.pink,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'OK',
            onPressed: _okPressed,
          ),
        );

        _scaffoldKey.currentState.showSnackBar(_snackBar);
      }

      if (_result >= 30) {
        final _snackBar = SnackBar(
          content: Text('You are Obese'),
          backgroundColor: Colors.pink,
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'OK',
            onPressed: _okPressed,
          ),
        );

        _scaffoldKey.currentState.showSnackBar(_snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Please Enter Your age",
                          hintText: "in years",
                          icon: Icon(Icons.person_outline)),
                    ),
                    TextField(
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Please Enter Your height",
                          hintText: "in inches",
                          icon: Icon(Icons.photo_size_select_actual)),
                    ),
                    TextField(
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Please Enter Your weight",
                          hintText: "in pounds",
                          icon: Icon(Icons.line_weight)),
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
                          onPressed: () => _displayBMI(_weight, _height, 703),
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
            Padding(padding: EdgeInsets.all(30.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _result > 0
                      ? "Your BMI is: ${_result.toStringAsFixed((1))}"
                      : "",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _okPressed() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }
}
