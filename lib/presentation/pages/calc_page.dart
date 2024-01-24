import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:function_tree/function_tree.dart';
import 'package:trinity_lecture_app/presentation/widgets/atoms/text_theme_extension.dart';
import 'package:trinity_lecture_app/presentation/widgets/molecules/action_text.dart';
import 'package:trinity_lecture_app/presentation/widgets/molecules/platform_app_bar.dart';
import 'package:trinity_lecture_app/presentation/widgets/organisms/ui_helper.dart';

@RoutePage()
class CalcPage extends StatelessWidget {
  const CalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorScreen();
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  //double result = 0.0;
  String result = '...';
  int selectedIndex = -1;
  bool hasHistory = false;
  String selectedButtonText = ''; // Default text

  TextEditingController leftController = TextEditingController();
  TextEditingController rightController = TextEditingController();

  void calculate(String value1, String value2, String type) {

    String input = value1 + type + value2;

    try {
      setState(() {
        result = eval(input).toString();
      });
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }
  }

  double eval(String expression) {
    return expression.interpret().toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PlatformAppBar(
        title: Text(
          'Simple Calculator',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "CHOOSE TYPE",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableButton(index: 0, type: "Add", isSelected: selectedIndex == 0, onPressed: () {
                  updateSelectedButton(0, '+');
                }),
                SelectableButton(index: 1, type: "Subtract", isSelected: selectedIndex == 1, onPressed: () {
                  updateSelectedButton(1, '-');
                }),
                SelectableButton(index: 2, type: "Multiply", isSelected: selectedIndex == 2, onPressed: () {
                  updateSelectedButton(2, 'X');
                })
              ],
            ),
            const SizedBox(height : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SelectableButton(index: 3, type: "Divide", isSelected: selectedIndex == 3, onPressed: () {
                  updateSelectedButton(3, '/');
                }),
                const SizedBox(width: 20),
                SelectableButton(index: 4, type: "Pow", isSelected: selectedIndex == 4, onPressed: () {
                  updateSelectedButton(4, '^');
                })
              ],
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: selectedIndex != -1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RoundedInputField(
                    controller: leftController,
                    hintText: '',
                  ),
                  const SizedBox(width: 20),
                  Text(
                      style: const TextStyle(fontSize: 25),
                      selectedButtonText
                  ),
                  const SizedBox(width: 20),
                  RoundedInputField(
                    controller: rightController,
                    hintText: '',
                  ),
                  const SizedBox(width: 20),
                  const Text(
                      style: TextStyle(fontSize: 25),
                      '='
                  ),
                  const SizedBox(width: 20),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightGreen[50],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.green,
                        size: 16,
                      ),
                      Text(
                          "Press calculate button to get the result",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold// Change text color when selected
                          )
                      ),
                    ],
                  ),
                )
            ),
            const SizedBox(height: 10),
            const Text(
              "HISTORY",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
            Visibility(
              visible: true,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                          "1 ^ 2",
                          style: TextStyle(
                              fontSize: 20
                          )
                      ),
                      const Expanded(
                        child: SizedBox(), // Empty space to push the "Calculate" button to the bottom
                      ),
                      Text(
                        "Re-Apply",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[600]
                        ),

                      ),
                    ],
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(), // Empty space to push the "Calculate" button to the bottom
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  calculate(leftController.text, rightController.text, selectedButtonText);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[100], // Highlight in blue when selected
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                ),
                child: const Text(
                    "CALCULATE",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold// Change text color when selected
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedButton(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      selectedButtonText = buttonText;
    });
  }
}

class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const RoundedInputField({super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}

class SelectableButton extends StatelessWidget {
  final int index;
  final String type;
  final bool isSelected;
  final VoidCallback onPressed;

  SelectableButton({
    required this.index,
    required this.type,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.lightBlue[100] : Colors.white, // Highlight in blue when selected
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        side: const BorderSide(
          color : Colors.black
        )
      ),
      child: Text(
          type,
          style: context.textTheme.bodyMedium?.copyWith(
            color: isSelected ? Colors.blue : Colors.black, // Change text color when selected
          ),
      ),
    );
  }
}
