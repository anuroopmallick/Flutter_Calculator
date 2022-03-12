import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main()
{
   runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget
{
   @override
   Widget build(BuildContext context)
   {
      return MaterialApp(
         debugShowCheckedModeBanner: false,
         home: HomePage(),
      );
   }
}

class HomePage extends StatefulWidget
{
   @override
   _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
   var userQuestion = "";
   var userAnswer = "";

   final List<String> buttons =
   [
      'C','DEL','%','/',
      '9','8','7','x',
      '6','5','4','-',
      '3','2','1','+',
      '0','.','ANS','='
   ];

   @override
   Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       backgroundColor: Colors.deepPurple[100],
       body: Column(
          children: <Widget>[
             Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 50,),
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                          child: Text(userQuestion,style: TextStyle(fontSize: 20))),
                      Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.centerRight,
                          child: Text(userAnswer,style: TextStyle(fontSize: 20)))
                    ],
                  ),
                ),
             ),
             Expanded(
                flex: 2,
                child: Container(
                    child: GridView.builder(
                       itemCount: buttons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index){

                         //Clear Button
                         if(index == 0){
                            return MyButton(
                                Colors.green,
                                Colors.white,
                                buttons[index],
                                (){
                                  setState(() {
                                    userQuestion='';
                                  });
                                }
                            );
                         }

                         //Delete Button
                         else if(index == 1){
                            return MyButton(
                                Colors.red,
                                Colors.white,
                                buttons[index],
                                (){
                                  setState(() {
                                    userQuestion=userQuestion.substring(0, userQuestion.length-1);
                                  });
                                }
                            );
                         }

                         //Equal Button
                         else if(index == buttons.length-1){
                           return MyButton(
                               Colors.purple,
                               Colors.white,
                               buttons[index],
                                   (){
                                 setState(() {
                                   equalPressed();
                                 });
                               }
                           );
                         }

                         //Rest of the buttons
                         else{
                            return MyButton(
                                isOperator(buttons[index]) ? Colors.deepPurple: Colors.deepPurple[50],
                                isOperator(buttons[index]) ? Colors.white: Colors.deepPurple,
                                buttons[index],
                                (){
                                  setState(() {
                                    userQuestion+= buttons[index];
                                  });
                                }
                            );
                         }
                        }),
                ),
             )
          ],
       ),
    );
  }
   bool isOperator(String x)
   {
     if(x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '%' || x == '=' )
     {
       return true;
     }
     return false;
   }

   void equalPressed(){
     String finalQuestion = userQuestion;
     finalQuestion = finalQuestion.replaceAll('x', '*');

     Parser p = Parser();
     Expression exp = p.parse(finalQuestion);
     ContextModel cm = ContextModel();
     // Evaluate expression:
     double eval = exp.evaluate(EvaluationType.REAL, cm);

     userAnswer = eval.toString();
   }
}

