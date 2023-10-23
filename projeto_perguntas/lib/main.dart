import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String _output = '';
  String _currentNumber = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';
  bool _isOperatorClicked = false;

  void _buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = '';
      _currentNumber = '';
      _num1 = 0;
      _num2 = 0;
      _operator = '';
      _isOperatorClicked = false;
    } else if (buttonText == '+' || buttonText == '-' || buttonText == '×' || buttonText == '÷') {
      if (_isOperatorClicked) {
        _operator = buttonText;
      } else {
        _num1 = double.parse(_currentNumber);
        _operator = buttonText;
        _isOperatorClicked = true;
        _currentNumber = '';
      }
    } else if (buttonText == '=') {
      _num2 = double.parse(_currentNumber);
      if (_operator == '+') {
        _currentNumber = (_num1 + _num2).toString();
      } else if (_operator == '-') {
        _currentNumber = (_num1 - _num2).toString();
      } else if (_operator == '×') {
        _currentNumber = (_num1 * _num2).toString();
      } else if (_operator == '÷') {
        _currentNumber = (_num1 / _num2).toString();
      }
      _num1 = 0;
      _num2 = 0;
      _operator = '';
      _isOperatorClicked = false;
    } else {
      _currentNumber += buttonText;
    }

    setState(() {
      _output = _currentNumber;
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          _buttonPressed(buttonText);
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(80, 80)), // Define o tamanho do botão
          padding: MaterialStateProperty.all(EdgeInsets.all(20)), // Define o espaçamento interno
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 65.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('÷'),
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('×'),
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('-'),
                buildButton('C'),
                buildButton('0'),
                buildButton('='),
                buildButton('+'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
