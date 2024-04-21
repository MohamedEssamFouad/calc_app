import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home_Calc extends StatefulWidget {


  @override
  State<Home_Calc> createState() => _Home_CalcState();
}

class _Home_CalcState extends State<Home_Calc> {
  String userInput="";
  String result="0";
  List<String>buttonList=[
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: Column(

        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height/3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 47,
                      color: Colors.red,
                    ),
                  ),
                ),
                const Divider(color: Colors.red,),
              ],
            ),

          ),
          Expanded(child: Container(
            child: Padding(padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,

                ),



                itemBuilder: (BuildContext context,int index){
                  return CustomButton(buttonList[index]);
                },



              ),
            ),
          ),




          ),
        ],
      ),

    );

  }
  Widget CustomButton(String text ){
    return InkWell(
      onTap: (){
        setState(() {
          handledButton(text);
        });
      },
      splashColor: Color(0xFF1d2630),
      child: Ink(
        decoration: BoxDecoration(

          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(

            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      ),

    );

  }
  getColor(String text){
    if(text=="/"||
        text=="*"||
        text=="+"||
        text=="-"||
        text=="C"||
        text=="("||
        text==")"
    ){
      return const Color.fromARGB(255, 252, 100, 100);

    }
    return Colors.black;
  }
  getBgColor(String text){
    if(text=="AC"){
      return const Color.fromARGB(255, 252, 100, 100);

    }
    if(text=="="){
      return const Color.fromARGB(255, 104, 204, 159);

    }
    return const Color(0xFF1d2630);
  }
  handledButton(String text){
    if(text=="AC"){
      userInput="";
      result="0";
      return;
    }
    if(text=="C"){
      if(userInput.isNotEmpty){
        userInput=userInput.substring(0,userInput.length-1);
        return;
      }
      else{
        return null;
      }
    }
    if(text=="="){
      result=Calc();
      userInput=result;

      if(userInput.endsWith(".0")){
        userInput=userInput.replaceAll(".0", "");
        return;
      }
      if(result.endsWith(".0")){
        result=result.replaceAll(".0", "");
        return;
      }

    }
    userInput=userInput+text;

  }
  String Calc(){
    try{
      var exp=Parser().parse(userInput);
      var evaluation=exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }catch(e){
      return "Error";

    }

  }

}
