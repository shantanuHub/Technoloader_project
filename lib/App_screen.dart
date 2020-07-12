import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("welcome"),
        ),
        body: HomeScreen()
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentItem = "type issue";
  var days = ["type issue", "Tuesday", "Wednesday", "Thursday"];
  final picker = ImagePicker();
  File _image;

 Future getImage() async{
    final pickFile  = await  picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickFile.path);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 18.0,),
          DropdownButton<String>(
            items: days.map((String dropDownItem) {
              return DropdownMenuItem<String>(
                value: dropDownItem,
                child: Text(dropDownItem),
              );
            }).toList(),
            onChanged: (value) =>_onSelectItem(value),
            value: currentItem,
          ),

          SizedBox(height: 30.0,),

           Padding(
            padding: EdgeInsets.only(left: 15.0 , right: 15.0),
            child: TextField(
              autofocus: false,
              style: TextStyle(fontSize: 22.0 ,fontWeight: FontWeight.bold),
              minLines: 1,
              maxLines: 4,
              textAlign: TextAlign.center,
              onChanged: (value){
              },
              decoration: InputDecoration(
                hintText: "Issue",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(style: BorderStyle.solid)
                )
              ),
            ),
          ),
          SizedBox(height: 20.0,),

          Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(_image , height: 200.0, width: 200.0,),
          ),

          RaisedButton(
            onPressed: getImage,
            child: Text("Select Image"),
          ),
        ],
      ),
    );
  }

  void _onSelectItem(String value)
  {
    setState(() {
      currentItem = value;
    });
  }

}