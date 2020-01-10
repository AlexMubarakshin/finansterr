import 'package:flutter/material.dart';
import 'package:finansterr/controller/IndexController.dart';
import 'package:finansterr/model/index.dart';

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

    try {
      IndexController controller = IndexController();
      list = await controller.fetchMajorIndexes();
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
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
