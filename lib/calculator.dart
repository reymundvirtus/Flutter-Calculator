import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var userAnswer = '';
  final List<String> buttons = [
    'AC',
    '⌫',
    '+/-',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '%',
    '0',
    '.',
    '=',
  ];
  final font = GoogleFonts.inter();
  final tappedColor = const Color.fromRGBO(28, 86, 128, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(23, 24, 26, 1),
      body: Column(
        children: [
          // this expanded widget is used to display the user input and answer
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userInput,
                    style: TextStyle(
                      fontSize: userInputSized(userInput) ? 20 : 30,
                      color: Colors.white,
                      fontFamily: font.fontFamily,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(
                      fontSize: userAnswerSized(userAnswer) ? 30 : 50,
                      color: Colors.white,
                      fontFamily: font.fontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // this expanded widget is used to display the buttons
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Buttons(
                    buttonTapped: () {
                      setState(() {
                        userInput = '';
                        userAnswer = '';
                      });
                    },
                    buttonText: buttons[index],
                    color: const Color.fromRGBO(95, 96, 96, 1),
                    textColor: const Color.fromARGB(255, 166, 167, 168),
                  );
                } else if (index == 1) {
                  return Buttons(
                    buttonTapped: () {
                      setState(() {
                        userInput =
                            userInput.substring(0, userInput.length - 1);
                      });
                    },
                    buttonText: buttons[index],
                    color: const Color.fromRGBO(95, 96, 96, 1),
                    textColor: const Color.fromARGB(255, 166, 167, 168),
                  );
                } else if (index == 19) {
                  return Buttons(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: const Color.fromRGBO(25, 145, 255, 1),
                    textColor: const Color.fromRGBO(149, 200, 243, 1),
                  );
                } else {
                  return Buttons(
                    buttonTapped: () {
                      setState(() {
                        userInput += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? const Color.fromRGBO(1, 93, 178, 1)
                        : const Color.fromRGBO(48, 49, 54, 1),
                    textColor: const Color.fromRGBO(48, 153, 251, 1),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '+' || x == '-' || x == 'x' || x == '÷' || x == '+/-') {
      return true;
    }
    return false;
  }

  bool userInputSized(var x) {
    if (x.length > 18) {
      return true;
    }
    return false;
  }

  bool userAnswerSized(var x) {
    if (x.length > 9) {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalInput = userInput;
    finalInput = finalInput.replaceAll('x', '*');
    finalInput = finalInput.replaceAll('÷', '/');

    Parser parser = Parser();
    Expression exp = parser.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
