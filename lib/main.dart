import 'package:brazilian_real_to_cents_converter/model/bag_of_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/converter_bloc.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple brazilian real converter.',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ConverterPage(title: 'Brazilian real to coin converter'),
    );
  }
}

class ConverterPage extends StatelessWidget {
  final String title;
  ConverterPage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // BlocProvider is an InheritedWidget for Blocs
      body: BlocProvider(
        // This bloc can now be accessed from CityInputField
        // It is now automatically disposed (since 0.17.0)
        builder: (context) => ConverterBloc(),
        child: ConverterPageChild(),
      ),
    );
  }
}

class ConverterPageChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(vertical: 16),
       alignment: Alignment.center,
       child: BlocBuilder(
         bloc: BlocProvider.of<ConverterBloc>(context),
         builder: (BuildContext context, ConverterState state) {
            if (state is ConvertedValue){
              return buildColumnWithCoins(state.bagOfCoins);
            } else {// ConverterInitial
              return buildInitialInput();
            }
          },
       )
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: ValueInputField(),
    );
  }

  Column buildColumnWithCoins(BagOfCoins bagOfCoins) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ValueInputField(),
        Text("Total of coins: ${
          bagOfCoins.fiftyCentsCoins + 
          bagOfCoins.twentyFiveCentsCoins + 
          bagOfCoins.tenCentsCoins   + 
          bagOfCoins.fiveCentsCoins + 
          bagOfCoins.oneCentCoins 
          }"),
        if (bagOfCoins.fiftyCentsCoins > 0) Text("${bagOfCoins.fiftyCentsCoins} coin(s) of 50 cents"),
        if (bagOfCoins.twentyFiveCentsCoins > 0) Text("${bagOfCoins.twentyFiveCentsCoins} coin(s) of 25 cents"),
        if (bagOfCoins.tenCentsCoins > 0) Text("${bagOfCoins.tenCentsCoins} coin(s) of 10 cents"),
        if (bagOfCoins.fiveCentsCoins > 0) Text("${bagOfCoins.fiveCentsCoins} coin(s) of 5 cents"),
        if (bagOfCoins.oneCentCoins > 0) Text("${bagOfCoins.oneCentCoins} coin(s) of 1 cent"),
      ],
    );
  }
}

class ValueInputField extends StatefulWidget {
  const ValueInputField({
    Key key,
  }) : super(key: key);

  @override
  _ValueInputFieldState createState() => _ValueInputFieldState();
}

class _ValueInputFieldState extends State<ValueInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: submitBrazilianRealValue,
        textInputAction: TextInputAction.go,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Enter a brazilian real value",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }

  void submitBrazilianRealValue(String value) {
    double doubleValue = double.parse(value);

    final weatherBloc = BlocProvider.of<ConverterBloc>(context);
    weatherBloc.dispatch(ConvertRealToCents(doubleValue));
  }
}