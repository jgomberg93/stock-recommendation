import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class ResultsPage extends StatefulWidget {
  ResultsPage({Key key, this.company}) : super(key: key);

  final String company;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

_makeGetRequest(company) async {
  var url = 'https://Stock-thing.oxxxm.repl.co/results/$company';
  var response = await http.get(url);
  print(response.body);
  return json.decode(response.body);
}

class _ResultsPageState extends State<ResultsPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Stock Recommendation",
            style: TextStyle(fontFamily: 'Imbue', fontSize: 28)
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FutureBuilder(
              future: _makeGetRequest(widget.company),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text('Recommendation: ${snapshot.data["Sentiment"]}',
                          style: TextStyle(fontSize: 30, fontFamily: 'Imbue'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 30, 220, 0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text('Related Articles:',
                            style: TextStyle(fontSize: 30, fontFamily: 'Imbue'),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .65,
                        child: ListView.builder(
                          itemCount: snapshot.data["Links"].length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var currentItem = snapshot.data["Links"][index];
                            return Card(
                              child: Padding (
                                padding: const EdgeInsets.all(10),
                                child: Linkify(
                                  onOpen: (link) async {
                                    if (await canLaunch(link.url)) {
                                      await launch(link.url);
                                    } else {
                                      throw 'Could not launch $link';
                                    }
                                  },
                                  text: '$currentItem',
                                  style: TextStyle(fontSize: 20, fontFamily: 'Imbue'),
                                  textAlign: TextAlign.left,
                                  options: LinkifyOptions(humanize: true)
                                ),
                              )
                            );
                          },
                        ),
                      ),
                    ]
                  );
                }

                else if(snapshot.hasError) {
                  return Text('Error: ${snapshot.error.toString()}');
                }

                else {
                  return Center (
                    child: Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: CircularProgressIndicator()
                    )
                  );
                }
              }
            ),
          ],
        ),
      )
    );
  }
}