import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:fruit_hub/view/cart.dart';
import 'package:fruit_hub/view/searchscreen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'newproduct.dart';
 
class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ProductListScreen(),
      ),
    );
  }
  
}


class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List _productList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Fruit Hub"), backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (content)=>SearchScreen()));
            }),
            IconButton(
            icon: Icon(Icons.shopping_cart), onPressed: (){
            //  Navigator.push(context, MaterialPageRoute(builder: (content)=>CartScreen()));
            })
        ],
        
      ),
      body: Center(
        child: Column(
          children: [
            _productList == null 
            ? Flexible(
                child: Center(
                  child: Text("No data available.")),
            )
            : Flexible(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                      itemCount: _productList.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: (screenWidth / screenHeight) /0.9),
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            child: InkWell(
                              onTap: (){
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color:Colors.grey[600],
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    ),
                                  ]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius:BorderRadius.only(
                                      topLeft:Radius.circular(10),
                                      topRight:Radius.circular(10),),
                                      child: CachedNetworkImage(
                                        imageUrl: CONFIG.SERVER + "/fruithub/images/products/${_productList[index]['prid']}.png",
                                        height: 150,
                                        width: 150,)
                                      ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:[
                                        Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                                        child: Text(_productList[index]['prname'],
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 16)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
                                          child: Text("RM " + _productList[index]['prprice'],
                                          style: TextStyle(fontSize:16)),
                                        ),
                                      ] 
                                    ), 
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(_productList[index]['prtype'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize:14,)),
                                        ),
                                        
                                      ],),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text("Quantity : "+_productList[index]['prqty'],
                                          style: TextStyle(fontSize:14)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                    ),
                  ),
              )
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.indigo,
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context)=>NewProductScreen())
          );
        },
        child: Icon(Icons.add),),
    );
  }
    void _loadProducts() {

    http.post(
      Uri.parse(CONFIG.SERVER + "/fruithub/php/loadproducts.php"),
      body: {
      }).then(
        (response){
          if(response.body == "nodata"){
            titleCenter = "No data available.";
            return;
          }else{
            var jsondata = json.decode(response.body);
            _productList = jsondata["products"];
            titleCenter = "Contain Data";
            setState(() {});
            print(_productList);
          }
      }
    );
  }
}


