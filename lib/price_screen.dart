import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'bitcoin_api.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double currencyValue = 0.0;

  //For Andriod view
  DropdownButton<String> andriodDropDown() {
    List<DropdownMenuItem<String>> currencyList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem<String>(
        value: currency,
        child: Text(currency),
      );
      currencyList.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencyList,
      onChanged: (value) async {
        var response = await updateTicker(selectedCurrency);
        setState(() {
          currencyValue = response['high'];
          selectedCurrency = value;
        });
      },
    );
  }

  //IOS view cupertino picker
  CupertinoPicker iosPicker() {
    List<Text> currencyList = [];
    for (String currency in currenciesList) {
      currencyList.add(Text(currency));
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (value) async {
          var response = await updateTicker(currencyList[value].data);
          setState(() {
            currencyValue = response['high'];
            selectedCurrency = currencyList[value].data;
          });
        },
        children: currencyList);
  }

  Future updateTicker(String currencyType) async {
    BitcoinApi bitcoinApi = BitcoinApi(currencyType);
    var response = await bitcoinApi.getCurrencyValue();
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInitialState();
  }

  @override
  void setInitialState() async {
    var response = await updateTicker(selectedCurrency);
    setState(() {
      currencyValue = response['high'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? $currencyValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? $currencyValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.all(30.0),
            color: Colors.lightBlue,
            child: Center(
              child: Platform.isIOS ? iosPicker() : andriodDropDown(),
            ),
          ),
        ],
      ),
    );
  }
}
