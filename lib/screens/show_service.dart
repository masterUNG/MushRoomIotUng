import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowService extends StatefulWidget {
  @override
  _ShowServiceState createState() => _ShowServiceState();
}

class _ShowServiceState extends State<ShowService> {
  // Explicit
  String url1 =
      'https://thingspeak.com/channels/437885/charts/1?bgcolor=%23ffffff&color=%23d62020&dynamic=true&results=60&type=line&update=15&fbclid=IwAR1DEG_NqQt8U5P3DjyIHLsLTTfpbg90LbUkPjjY5rbn9RifsbIDZDT00E0';

  Widget showGraph(String urlStrig) {
    return WebView(
      initialUrl: urlStrig,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  Widget showCuTemp() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        child: Text('cutemp'),
      ),
    );
  }

  Widget showCuHumi() {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        child: Text('cuHumi'),
      ),
    );
  }

  Widget showPanal(String labelString, String valueString) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(valueString),
          RaisedButton(
            child: Text(labelString),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget showThinkSpeak(String urlString) {
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
        height: 250.0,
        child: showGraph(urlString),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Service'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            showCuTemp(),
            showCuHumi(),
            Container(
              width: 240.0,
              child: Row(
                children: <Widget>[
                  showPanal('Fog', '0'),
                  showPanal('Fan', '1'),
                  showPanal('Light', '0'),
                ],
              ),
            ),
            showThinkSpeak(url1),
            showThinkSpeak(url1),
            showThinkSpeak(url1),
            showThinkSpeak(url1),
          ],
        ),
      ),
    );
  }
}
