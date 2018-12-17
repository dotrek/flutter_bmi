import 'dart:math';

import 'package:flutter/material.dart';

class BMIHome extends StatefulWidget {
  @override
  _BMIHomeState createState() => _BMIHomeState();
}

class _BMIHomeState extends State<BMIHome> {
  var _ageController = TextEditingController();
  var _heightController = TextEditingController();
  var _weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text("BMI Calculator"),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.5),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Image.asset("assets/bmilogo.png"),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _ageController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Should not be empty';
                              }
                            },
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: "Age",
                            ),
                          ),
                          TextFormField(
                            controller: _heightController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Should not be empty';
                              }
                            },
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              icon: Icon(Icons.assessment),
                              hintText: "Height in centimetres",
                            ),
                          ),
                          TextFormField(
                            controller: _weightController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Should not be empty';
                              }
                            },
                            keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              icon: Icon(Icons.line_weight),
                              hintText: "Weight in kilos",
                            ),
                          ),
                          FlatButton(
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: calculateBMI,
                            child: Text("Calculate"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  calculateBMI() {
    setState(() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        int age = int.parse(_ageController.value.text);
        print(age);
        int height = int.parse(_heightController.value.text);
        print(height);
        double weight = double.parse(_weightController.value.text);
        print(weight);
        double bmiValue = weight / pow(height / 100, 2);
        bmiStates state = setBMIState(bmiValue);
        print(bmiValue);
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text("Your BMI value"),
                  content: Column(children: [
                    Text(bmiValue.toString()),
                    Text("Your state is: $state")
                  ]),
                ));
      }
    });
  }

  bmiStates setBMIState(double bmiValue) {
    if (bmiValue > 18.5) {
      if (bmiValue <= 24.9) {
        return bmiStates.Normal;
      } else if (bmiValue < 30) {
        return bmiStates.Overweight;
      } else {
        return bmiStates.Obesity;
      }
    } else {
      return bmiStates.Underweight;
    }
  }
}
enum bmiStates {
  Underweight,
  Normal,
  Overweight,
  Obesity
}