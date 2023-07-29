import 'package:flutter/material.dart';
import 'calculation.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Basic Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '0';
  double _result = 0;
  Calculation _calculation = Calculation();

  void _handleButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _clearInput();
      } else if (buttonText == '=') {
        _evaluateExpression();
      } else {
        _appendToInput(buttonText);
      }
    });
  }

  void _clearInput() {
    _input = '0';
    _result = 0;
  }

  void _appendToInput(String text) {
    if (_input == '0') {
      _input = text;
    } else {
      _input += text;
    }
  }

  void _evaluateExpression() {
    try {
      if (_input.contains('+')) {
        List<String> numbers = _input.split('+');
        _result = _calculation.add(double.parse(numbers[0]), double.parse(numbers[1]));
      } else if (_input.contains('-')) {
        List<String> numbers = _input.split('-');
        _result = _calculation.subtract(double.parse(numbers[0]), double.parse(numbers[1]));
      } else if (_input.contains('*')) {
        List<String> numbers = _input.split('*');
        _result = _calculation.multiply(double.parse(numbers[0]), double.parse(numbers[1]));
      } else if (_input.contains('/')) {
        List<String> numbers = _input.split('/');
        _result = _calculation.divide(double.parse(numbers[0]), double.parse(numbers[1]));
      } else {
        _result = double.parse(_input);
      }
      _input = _result.toString();
    } catch (e) {
      _input = 'Error';
    }
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _handleButtonPress(buttonText),
        child: Text(buttonText),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Basic Calculator')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              color: Colors.black87,
              child: Text(
                _input,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Divider(height: 1.0),
          Container(
            height: 400.0,
            color: Colors.black54,
            child: GridView.count(
              crossAxisCount: 4,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
                _buildButton('C'),
                _buildButton('0'),
                _buildButton('='),
                _buildButton('+'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
