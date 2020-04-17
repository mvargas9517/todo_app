import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();

  _showFormInDialog(BuildContext context) {
    return showDialog(context: context, barrierDismissible: true, builder: (param) {
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            onPressed: () {

            },
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
//              print('Category Name' : $_categoryName);
//              print('Category Description' : $_categoryDescription);
            },
            child: Text('Save'),
          ),
        ],
          title: Text('Category Form'), content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _categoryName,
              decoration: InputDecoration(
                labelText: 'Category Name',
                hintText: 'Write category name'
              ),
            ),
            TextField(
              controller: _categoryDescription,
              decoration: InputDecoration(
                  labelText: 'Category description',
                  hintText: 'Write category description'
              ),
            ),
          ],
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          elevation: 0.0,
          color: Colors.red,
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new HomeScreen()));
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('Todo app'),
      ),
      body: Center(child: Text('Welcome to categories screen'),),
      floatingActionButton: FloatingActionButton(onPressed: () {_showFormInDialog(context);}, child: Icon(Icons.add),),
    );
  }
}
