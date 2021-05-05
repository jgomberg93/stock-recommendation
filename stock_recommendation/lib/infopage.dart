import 'package:flutter/material.dart';
import 'package:stock_recommendation/resultspage.dart';

class InfoPage extends StatefulWidget {

  @override
  _InfoPageState createState() => _InfoPageState();
}


class _InfoPageState extends State<InfoPage> {

  TextEditingController controller = TextEditingController();
  String company = "";


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
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextField(
                  onChanged: (v)=>setState(() {company=v;}),
                  decoration: const InputDecoration(
                    hintText: 'Enter a company name',
                  ),
                  controller: controller,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: OutlineButton(
                  child: Text('Submit'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultsPage(company: company)),
                    );
                    print(company);
                    controller.clear();
                  }
                ),
              ),
              Text("Enter the name of a company that you would like to get an opinion on if you should invest in its stock.",
                  style: TextStyle(fontSize: 30, fontFamily: 'Imbue'),
              ),
              Padding (
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Image(
                  image: AssetImage('assets/images/Investing.jpg'),
                  //height: 250,
                ),
              ),
              Text("Disclaimer: This advice is only an opinion formed from recent news articles, it should not be taken as professional advice.",
                style: TextStyle(fontSize: 20, fontFamily: 'Imbue'),
              ),
            ],
          ),
        )
    );
  }
}
