import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/services/category_service.dart';
import 'package:todoapp/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = List<Category>();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.getCategories();
    categories.forEach((category) {
    setState(() {
      var model = Category();
      model.name = category['name'];
      _categoryList.add(model);
    });


    }
    );
  }

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
            onPressed: () async {
              _category.name = _categoryName.text;
              _category.description = _categoryDescription.text;
            var result = await _categoryService.saveCategory(_category);
            print(result);
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
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new HomeScreen()));
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text('Todo app'),
        ),
        body: ListView.builder(
            itemCount: _categoryList.length, itemBuilder: (context, index) {
          return Card(child: ListTile(
            leading: Icon(Icons.edit),
            onTap: () {},
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_categoryList[index].name),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},)
              ],
            ),));
        }),

      floatingActionButton: FloatingActionButton(onPressed: () {_showFormInDialog(context);}, child: Icon(Icons.add),),
  );
  }
}
