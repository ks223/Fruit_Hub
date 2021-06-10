import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = new TextEditingController();
  String _centermessage = "No item found.";
  List _searchList;
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green[300],
          title: Container(
              height: 40,
              child: TextField(
                controller: _searchController,
                style: TextStyle(fontSize: 18),
                decoration: new InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    border: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    filled: true,
                    hintText: "Search"),
              )),
          actions: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searchItem();
                    }))
          ],
        ),
        body: Container(
                 child: Column(
          children: [
            _searchList == null
                ? Flexible(child: Center(child: Text(_centermessage)))
                : Flexible(
                    child: Center(
                        child: Container(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: (screenWidth / screenHeight) / 0.9,
                        children: List.generate(_searchList.length, (index) {
                          return Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(
                                  child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            CONFIG.SERVER + "/fruithub/images/products/${_searchList[index]['prid']}.png",
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 20, 0, 0),
                                          child: Text(
                                              _searchList[index]['prname'],
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 0),
                                        child: Text(
                                          "RM " +
                                              _searchList[index]['prprice'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ]),
                                  ]),
                                        ),
                                      ),
                                    );
                                  }),
                        ))
                )),
            ])),
        );
  }
  void _searchItem() {
    String searchItem = _searchController.text.toString();
    print(searchItem);
    http.post(
        Uri.parse(
            CONFIG.SERVER + "/fruithub/php/loadproducts.php"),
        body: {"prname": searchItem}).then((response) {
      if (response.body == "nodata") {
        _searchList = null;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _searchList = jsondata["products"];
        print(_searchList);
        setState(() {});
      }
    });
  }

}