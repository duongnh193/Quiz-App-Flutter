import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/generate_quiz.dart';
import 'package:quiz_app/screens/homepage/homepage.dart';

import '../../constant.dart';
import '../../data/questions.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key, required this.results}) : super(key: key);
  final List<Result> results;

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<Result> _results = [];
  @override

  void initState() {
    super.initState();
    _results = widget.results ;
  }

  void _clearResults() {
    setState(() {
      _results.clear();
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: const Text(
          'Result History',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kSecondaryColor
          ) ,
        ),
        leading: IconButton(
            onPressed: (){
              Navigator.push(
                  context, 
                  MaterialPageRoute(
                      builder: (context){
                        return HomePageScreen();
                      }
                  )
              );
            },
            icon: Icon(CupertinoIcons.arrow_left)),
        actions: [
          IconButton(
              onPressed: _results.isEmpty ? null : _clearResults ,
              icon: Icon(Icons.delete),
          )
        ],
      ),
      body: _results.isEmpty
        ?  Container(
        width: size.width,
        height: size.width*0.12,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No results yet!!",
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index){
                final result = _results[index];
                return ListTile(
                  title: Text(
                    "Quiz ${index+1}",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    "Correct: ${result.numCorrect}/${result.numTotal}\n"
                    "Time: ${result.timeTaken.inMinutes}m ${result.timeTaken.inSeconds % 60}s",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: (){
                        setState(() {
                          _results.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete_forever)
                  ),
                );
              }
      ),
    );
  }
}
