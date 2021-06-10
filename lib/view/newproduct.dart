import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'config.dart';
import 'productlist.dart';

class NewProductScreen extends StatefulWidget {
  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  double screenHeight, screenWidth;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _typeController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController();
  File _image;
  String pathAsset = 'assets/images/not_available.png';

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:
          AppBar(title: Text("Add Product"), backgroundColor: Colors.red[300]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: screenHeight / 2.35,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,50),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: _image == null
                            ? AssetImage(pathAsset)
                            : FileImage(_image),
                        fit: BoxFit.scaleDown,
                      )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                       border: Border.all(color: Colors.black),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          Icons.image,
                          size: 22,
                        ),
                        onPressed: () {
                          _onPictureSelectionDialog();
                        },
                      )),
                )
              ]),
            ),
            SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    width: screenWidth / 1.1,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[600],
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          )
                        ],
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        ListTile(
                          title: TextField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Product Name:",
                            ),
                          ),
                        ),
                        ListTile(
                          title: TextField(
                            controller: _typeController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: "Product Type:",
                            ),
                          ),
                        ),
                        ListTile(
                          title: TextField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Price (RM):",
                            ),
                          ),
                        ),
                        ListTile(
                          title: TextField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Quantity:",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minWidth: screenWidth / 1.5,
                  height: screenHeight / 15,
                  child: Text(
                    'Add Product',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, fontFamily: 'Arial'),
                  ),
                  onPressed: () {
                    onAddProduct();
                  },
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onAddProduct() {
    String _name = _nameController.text.toString();
    String _type = _typeController.text.toString();
    String _price = _priceController.text.toString();
    String _quantity = _quantityController.text.toString();

    if (_name.isEmpty && _type.isEmpty && _price.isEmpty && _quantity.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill in all the field provided.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_name.isEmpty) {
      Fluttertoast.showToast(
          msg: "Product Name is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_type.isEmpty) {
      Fluttertoast.showToast(
          msg: "Product Type is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_price.isEmpty) {
      Fluttertoast.showToast(
          msg: "Price is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_quantity.isEmpty) {
      Fluttertoast.showToast(
          msg: "Quantity is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_image == null) {
      Fluttertoast.showToast(
          msg: "Please insert image",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text('Adding new product',
                style: Theme.of(context).textTheme.headline5),
            content: Text("Are you sure?",
                style: Theme.of(context).textTheme.bodyText1),
            actions: [
              TextButton(
                child:
                    (Text('Yes', style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  _addProduct(_name, _type, _price, _quantity);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child:
                    (Text('No', style: Theme.of(context).textTheme.bodyText2)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _onPictureSelectionDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: new Container(
              padding: EdgeInsets.all(0),
              width: screenWidth / 5,
              height: screenHeight / 5.5,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "Camera",
                        style: TextStyle(fontSize: 18, fontFamily: 'Calibri'),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.blue,
                      ),
                      onTap: () => {Navigator.pop(context), _chooseCamera()},
                    ),
                    SizedBox(height: 5),
                    ListTile(
                      leading: Icon(
                        Icons.photo_album_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(
                        "Gallery",
                        style: TextStyle(fontSize: 18, fontFamily: 'Calibri'),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.blue,
                      ),
                      onTap: () => {Navigator.pop(context), _chooseGallery()},
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 1000,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _cropImage();
  }

  Future<void> _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 1000,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    _cropImage();
  }

  void _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Colors.blue,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _addProduct(String name, String type, String price, String quantity) {
    String base64Image = base64Encode(_image.readAsBytesSync());
    print(base64Image);
    print(name);
    print(type);
    print(price);
    print(quantity);

    http.post(Uri.parse(CONFIG.SERVER + "/fruithub/php/newproduct.php"), body: {
      "prname": name,
      "prtype": type,
      "prprice": price,
      "prqty": quantity,
      "encoded_string": base64Image,
    }).then((response) {
      print(response.body);

      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Product added successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ProductListScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Failed to add Product.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
