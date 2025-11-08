import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String expression = "";
  String result = "0";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        expression = "";
        result = "0";
      } else if (buttonText == "AC") {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
          if (expression.isEmpty) {
            result = "0";
          }
        }
      } else if (buttonText == "=") {
        try {
          String finalExpression = expression.replaceAll('x', '*');

          GrammarParser parser = GrammarParser();
          Expression exp = parser.parse(finalExpression);
          ContextModel cm = ContextModel();

          result = '${RealEvaluator(cm).evaluate(exp).toDouble()}';

          if (result.endsWith(".0")) {
            result = result.substring(0, result.length - 2);
          }
          expression = result;
        } catch (e) {
          result = "Erro";
          expression = "";
        }
      } else {
        if (result != "0" &&
            expression == result &&
            !['+', '-', 'x', '/'].contains(buttonText)) {
          expression = buttonText;
        } else if (result == "Erro") {
          expression = buttonText;
          result = "0";
        } else {
          expression += buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 224, 217, 217),
        child: Column(
          children: <Widget>[
            CalculatorDisplay(expression: expression, result: result),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                color: Color.fromARGB(255, 224, 217, 217),
                child: buildButtonGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonGrid() {
    final List<List<String>> buttonRows = [
      ['C', 'AC', '%', '/'],
      ['7', '8', '9', 'x'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['0', '.', '='],
    ];

    return Column(
      children: buttonRows.map((row) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: row.map((buttonText) {
              if (buttonText == '=') {
                return Expanded(
                  flex: 2,
                  child: CalculatorButton(
                    text: buttonText,
                    onPressed: () => buttonPressed(buttonText),
                    isOperator: true,
                  ),
                );
              } else {
                return Expanded(
                  flex: 1,
                  child: CalculatorButton(
                    text: buttonText,
                    onPressed: () => buttonPressed(buttonText),
                    isOperator: ['/', '%', 'x', '-', '+'].contains(buttonText),
                    isClearOrDelete: ['C', 'AC'].contains(buttonText),
                  ),
                );
              }
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
