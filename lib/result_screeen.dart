import 'package:flutter/material.dart';
import 'calculations.dart';

class ResultScreen extends StatefulWidget {
  final String help;
  final String hope;

  ResultScreen({Key key, @required this.help, this.hope}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    displayBMI(widget.help, widget.hope, 703);

    final _snackBar = SnackBar(
      content: Text('Compare your BMI to the chart above'),
      backgroundColor: Colors.pink,
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: 'OK',
        onPressed: _okPressed,
      ),
    );

    Future<Null>.delayed(Duration(seconds: 1), () {
      _scaffoldKey.currentState.showSnackBar(_snackBar);
    });

    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _okPressed() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  double _result = 0.0;

  displayBMI(String height, String weight, int multiplier) async {
    setState(() {
      _result = calculateBMI(height, weight, multiplier);
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
                  child: Image.asset('images/bmichart.jpg'),
                ),
                Padding(padding: EdgeInsets.all(35.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
            )));
  }
}
