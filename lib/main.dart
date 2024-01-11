import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pinkAccent),
        fontFamily: 'Roboto',
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _equation = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _clear();
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      _setOperand(buttonText);
    } else if (buttonText == "=") {
      _calculate();
    } else {
      _updateOutput(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = "0";
      _equation = "";
      num1 = 0;
      num2 = 0;
      operand = "";
    });
  }

  void _setOperand(String newOperand) {
    setState(() {
      operand = newOperand;
      num1 = double.parse(_output);
      _equation += _output + " " + operand + " ";
      _output = "0";
    });
  }

  void _updateOutput(String buttonText) {
    setState(() {
      if (_output == "0" || _output == "Error") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    });
  }

  void _calculate() {
    setState(() {
      num2 = double.parse(_output);
      _equation += _output;
      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "*":
          _output = (num1 * num2).toString();
          break;
        case "/":
          if (num2 != 0) {
            _output = (num1 / num2).toString();
          } else {
            _output = "Error";
          }
          break;
        default:
          break;
      }
      operand = "";
      num1 = 0;
      num2 = 0;
    });
  }

  bool _isOperator(String buttonText) {
    return buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/";
  }

  Widget _buildCircularButton(String text) {
    return GestureDetector(
      onTap: () => _buttonPressed(text),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.18,
        height: MediaQuery.of(context).size.width * 0.18,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isOperator(text) ? Theme.of(context).colorScheme.secondary : Colors.grey[300],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.bold,
              color: _isOperator(text) ? Colors.white : Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _equation,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      _output.contains(".") ? _output : _output.split('.')[0],
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    _buildCircularButton('7'),
                    _buildCircularButton('8'),
                    _buildCircularButton('9'),
                    _buildCircularButton('/'),
                    _buildCircularButton('4'),
                    _buildCircularButton('5'),
                    _buildCircularButton('6'),
                    _buildCircularButton('*'),
                    _buildCircularButton('1'),
                    _buildCircularButton('2'),
                    _buildCircularButton('3'),
                    _buildCircularButton('-'),
                    _buildCircularButton('C'),
                    _buildCircularButton('0'),
                    _buildCircularButton('='),
                    _buildCircularButton('+'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
