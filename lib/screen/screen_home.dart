import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/api_adapter.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_quiz.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Quiz> quizs = [];
  bool isLoading = false;

  _fetchQuizs() async {
    setState(() {
      isLoading = true;
    });
    final response = await http
        .get(Uri.parse('https://drf-quiz-test.herokuapp.com/quiz/3/'));
    if (response.statusCode == 200) {
      setState(() {
        quizs = parseQuizs(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else {
      throw Exception("failed to load data");
    }
  }

  // List<Quiz> quizs = [
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  //   Quiz.fromMap({
  //     'title': 'test',
  //     'candidates': ['a', 'b', 'c', 'd'],
  //     'answer': 0
  //   }),
  // ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
            child: Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                    title: const Text("My Quiz App"),
                    backgroundColor: Colors.deepPurple,
                    leading: Container()),
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Image.asset('images/test.jpeg',
                              width: width * 0.8)),
                      Padding(padding: EdgeInsets.all(width * 0.024)),
                      Text("????????? ?????? ???",
                          style: TextStyle(
                              fontSize: width * 0.065,
                              fontWeight: FontWeight.bold)),
                      const Text('????????? ?????? ??? ?????????????????????',
                          textAlign: TextAlign.center),
                      Padding(padding: EdgeInsets.all(width * 0.048)),
                      _buildStep(width, "1. ???????????? ????????? ?????? 3?????? ???????????????"),
                      _buildStep(
                          width, "2. ????????? ??? ?????? ????????? ?????? ???\n?????? ?????? ????????? ???????????????."),
                      _buildStep(width, "3. ????????? ?????? ??????????????????"),
                      Padding(padding: EdgeInsets.all(width * 0.048)),
                      Container(
                        padding: EdgeInsets.only(bottom: width * 0.036),
                        child: Center(
                            child: ButtonTheme(
                          minWidth: width * 0.8,
                          height: height * 0.05,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Row(children: <Widget>[
                                const CircularProgressIndicator(),
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.036)),
                                const Text("????????? ...")
                              ])));
                              _fetchQuizs().whenComplete(() {
                                return Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            QuizScreen(quizs: quizs)));
                              });
                            },
                            child: const Text(
                              "?????? ?????? ??????",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                      )
                    ]))));
  }

  Widget _buildStep(double width, String title) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            width * 0.048, width * 0.024, width * 0.048, width * 0.024),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.check_box, size: width * 0.04),
            Padding(padding: EdgeInsets.only(right: width * 0.024)),
            Text(title)
          ],
        ));
  }
}
