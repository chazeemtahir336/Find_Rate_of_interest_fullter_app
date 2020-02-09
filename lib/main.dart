import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: "Rate of Interest Find Calcultor",
      debugShowCheckedModeBanner: false,
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
      ),
    ));

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {

  var _formKey =GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds', 'Others'];
  var _currentItemsSelected = "Rupees";
  TextEditingController OrigenAmountController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var _displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text(
        "Interest Calculator",
        textScaleFactor: 1.2,
      )),
      body: Form(
        key: _formKey,
          child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: OrigenAmountController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please enter principal amount";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Enter the Origen Amount",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 15.0
                      ),
                      hintText: "Enter the Price e.g 1000"),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  validator: (String value){
                    if(value.isEmpty){
                      return "enter rate of interset";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Rate of Interest",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 15.0
                      ),
                      hintText: "Enter Price e.g 20"),
                )),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: termController,
                    validator: (String value){
                      if(value.isEmpty){
                        return "enter the Year's";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Term",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 15.0
                        ),
                        hintText: "Time of Year"),
                  )),
                  Container(
                    width: 25.0,
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    value: _currentItemsSelected,
                    onChanged: (String newValueSelected) {
                      _onDropdownItenSelected(newValueSelected);
                    },
                  ))
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              "Claculate",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {

                                if(_formKey.currentState.validate())
                                  {this._displayResult = _calculateTotalReturn();}
                              });
                            })),
                    Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              "Reset",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            }))
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                _displayResult,
                style: textStyle,
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _onDropdownItenSelected(String newValueSelected) {
    setState(() {
      this._currentItemsSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double Amount = double.parse(OrigenAmountController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalResult = Amount + (Amount * roi * term) / 100;
    String result =
        'After $term Years,You Investement Will be Worth $totalResult $_currentItemsSelected ';
    return result;
  }

  void _reset() {
    OrigenAmountController.text = '';
    roiController.text = '';
    termController.text = '';
    _displayResult = '';
    _currentItemsSelected = _currencies[0];
  }
}

Widget getImageAsset() {
  AssetImage assetImage = AssetImage("images/image2.jpg");
  Image image = Image(
    image: assetImage,
    width: 125.0,
    height: 125.0,
  );
  return Container(
    child: image,
    margin: EdgeInsets.all(50.0),
  );
}
