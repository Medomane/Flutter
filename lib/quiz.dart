import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestion=0;
  int score=0;
  final quiz = [
    {
      'title': 'Q 1 - Which of the following is correct about Java 8 lambda expression ?',
      'answers': [
        {'answer': 'A - Using lambda expression, you can refer to final variable or effectively final variable (which is assigned only once)', 'correct': false},
        {'answer': 'B - Lambda expression throws a compilation error, if a variable is assigned a value thesecond time ?', 'correct': false},
        {'answer': 'C - Both of the above.', 'correct': true},
        {'answer': 'D - None of the above.', 'correct': false},
      ],
    },
    {
      'title': 'Q 8 - Which of the following is the correct lambda expression which add two numbers and return their sum?',
      'answers': [
        {'answer': 'A - (int a, int b) -> { return a + b;};', 'correct': false},
        {'answer': 'B - (a, b) -> {return a + b;};', 'correct': false},
        {'answer': 'C - Both of the above.', 'correct': true},
        {'answer': 'D - None of the above.', 'correct': false},
      ],
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.orange
      ),
      body: (
        this.currentQuestion>=quiz.length)?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Score : ${(score/quiz.length*100).round()} %',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 22)),
              RaisedButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: (){
                    setState((){ currentQuestion=0; score=0; });
                  },
                  child: Text('Restart ...',style: TextStyle(color: Colors.white,fontSize: 22), )
              )
            ]
          )
         ):
        ListView(
            children: <Widget>[
              ListTile(
                title: Center(child: Text('Question : ${currentQuestion+1}/${quiz.length}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent)))
              ),
              ListTile (
                title: Text ('${quiz[currentQuestion]['title']} ?',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
              ),
              ...(quiz[currentQuestion]['answers'] as List<Map<String,Object>>).map(
                (answer){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.deepOrangeAccent,
                      onPressed: (){
                        setState(() {
                          if(answer['correct']==true) ++score;
                          ++this.currentQuestion;
                        });
                      },
                      child:Container(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(answer['answer'],style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)
                        ),
                        padding: EdgeInsets.all(10)
                      )
                    ),
                  );
                }
              )
            ]
        )
    );
  }
}