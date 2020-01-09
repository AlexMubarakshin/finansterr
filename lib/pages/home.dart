import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_started/models/index.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Index> list = List();
  bool isLoading = false;

  @override
  initState() {
    super.initState();

    this._fetchData();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http
        .get("https://financialmodelingprep.com/api/v3/majors-indexes");

    if (response.statusCode == 200) {
      List majorIndexesList = json.decode(response.body)['majorIndexesList'];

      list = majorIndexesList.map((data) => new Index.fromJson(data)).toList();

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Majors Indexes List'),
      ),
      body: Container(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isPriceUp = !!(list[index].price > 0);
                    return Container(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(context).dividerColor))),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Text(list[index].indexName),
                            ),
                            Expanded(
                              child: Text(
                                  '${isPriceUp ? "+" : "-"}${list[index].price}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: isPriceUp
                                          ? Colors.green
                                          : Colors.red)),
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline:
                              DefaultTextStyle.of(context).style.textBaseline,
                        ));
                  },
                )),
    );
  }
}
