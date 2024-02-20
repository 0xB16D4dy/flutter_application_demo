import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String httpResult = '';
  String httpsResult = '';

  void httpFetch() async {
    // Thực hiện yêu cầu HTTP
    DateTime requestTime = DateTime.now();
    String formattedTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(requestTime);
    try {
      var httpResponse = await http.get(Uri.parse('http://neverssl.com'));
      setState(() {
        httpResult = 'HTTP Result: ${httpResponse.statusCode}\n$formattedTime';
      });
    } catch (error) {
      setState(() {
        httpResult = 'HTTP ERROR: $formattedTime';
        print(error);
      });
    }
  }

  void httpsFetch() async {
    // Thực hiện yêu cầu HTTPS
    DateTime requestTime = DateTime.now();
    String formattedTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(requestTime);
    try {
      var request = await HttpClient()
          .getUrl(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      var response = await request.close();

      setState(() {
        httpsResult = 'HTTPS Result: ${response.statusCode}\n$formattedTime';
      });
    } catch (error) {
      print(error.toString());
      setState(() {
        httpsResult = "HTTPS ERROR: \n$formattedTime";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HTTP and HTTPS Example',
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: httpFetch,
              child: Text('HTTP'),
            ),
            const SizedBox(height: 20),
            Text(httpResult),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: httpsFetch,
              child: const Text('HTTPS'),
            ),
            Text(httpsResult),
          ],
        ),
      ),
    );
  }
}
