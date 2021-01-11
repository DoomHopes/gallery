import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  // key 6JoXsuUr3vZnZFLpXoX6Ja1G3-55o8d85-llwnEvO1s

  List data;
  String url =
      'https://api.unsplash.com/search/photos?per_page=30&client_id=6JoXsuUr3vZnZFLpXoX6Ja1G3-55o8d85-llwnEvO1s&query=car';
  String urlImage;

  @override
  void initState() {
    super.initState();
    fetchimage();
  }

  Future<String> fetchimage() async {
    var fethdata = await http.get(url);
    var jsondata;

    if (fethdata.statusCode == 200) {
      jsondata = json.decode(fethdata.body);
    }
    setState(() {
      data = jsondata['results'];
    });
    return "Ok";
  }

  _OnTapProcces(context) {
    return Dialog(
      child: Image.network(urlImage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gallery App",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Gallery App"),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) {
              //return Image.network(data[index]['urls']['small']);
              return Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        constraints: BoxConstraints.tightFor(width: 100.0),
                        child: Image.network(
                          data[index]['urls']['small'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      title: Text(data[index]['alt_description'].toString()),
                      subtitle: Text(data[index]['user']['name'].toString()),
                      onTap: () {
                        setState(() {
                          urlImage = data[index]['urls']['regular'];
                        });
                        showDialog(
                            context: context,
                            builder: (context) => _OnTapProcces(context));
                      },
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
