import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sarah Salvas Calculator', //Mostly authored by Copilot
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
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
  String _expression = '';
  String _result = '';

  void _onPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
        _result = '';
      } else if (text == '=') {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final r = evaluator.eval(expression, {});
          _result = ' = $r';
        } catch (e) {
          _result = ' Error';
        }
      } else {
        _expression += text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sarah Salvas'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                color: Colors
                    .white70, // Change background color of the accumulator
                child: Text(
                  '$_expression$_result',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .black), // Change text color to black for better contrast
                ),
              ),
            ),
            _buildButtonRow(['7', '8', '9', '/']),
            _buildButtonRow(['4', '5', '6', '*']),
            _buildButtonRow(['1', '2', '3', '-']),
            _buildButtonRow(['C', '0', '=', '+']),
            _buildButtonRow(['%', '^2']) // Add a new row with the modulo and squaring buttons
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((text) {
        return _buildButton(text);
      }).toList(),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () => _onPressed(text),
      child: Text(
        text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
