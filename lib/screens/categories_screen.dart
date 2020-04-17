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

  var _editCategoryName = TextEditingController();
  var _editCategoryDescription = TextEditingController();

  var category;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.getCategories();
    categories.forEach((category) {
    setState(() {
      var model = Category();
      model.name = category['name'];
      model.id = category['id'];
      model.description = category['description'];
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
              Navigator.pop(context);
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

  _editCategoryDialog(BuildContext context) {
    return showDialog(context: context, barrierDismissible: true, builder: (param) {
      return AlertDialog(
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () async {
                _category.id = category[0]['id'];
                _category.name = _editCategoryName.text;
                _category.description = _editCategoryDescription.text;
                var result = await _categoryService.updateCategory(_category);
                if (result > 0) {
                Navigator.pop(context);
                getAllCategories();
                _showSnackBar(Text('Update success'));
                }
                print(result);
              },
              child: Text('Update'),
            ),
          ],
          title: Text('Category edit form'), content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _editCategoryName,
              decoration: InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'Write category name'
              ),
            ),
            TextField(
              controller: _editCategoryDescription,
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

  _deleteCategoryDialog(BuildContext context, categoryId) {
    return showDialog(context: context, barrierDismissible: true, builder: (param) {
      return AlertDialog(
          actions: <Widget>[
            FlatButton(
              color: Colors.green,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel',
              style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              color: Colors.red,
              onPressed: () async {
                await _categoryService.deleteCategory(categoryId);
                Navigator.pop(context);
                getAllCategories();
                _showSnackBar(Text('Delete success'));
              },
              child: Text('Delete',
              style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          title: Text('Delete this task?'));
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.getCategoryById(categoryId);
    setState(() {
      _editCategoryName.text = category[0]['name'] ?? 'No name';
      _editCategoryDescription.text = category[0]['description'] ?? 'No description';
    });

    _editCategoryDialog(context);
  }

  _showSnackBar(message) {
    var _snackBar = SnackBar(
      content: message,
    );
    _scaffoldkey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
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
            onTap: () {
              _editCategory(context, _categoryList[index].id);
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_categoryList[index].name),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteCategoryDialog(context, _categoryList[index].id);
                  },)
              ],
            ),));
        }),

      floatingActionButton: FloatingActionButton(onPressed: () {_showFormInDialog(context);}, child: Icon(Icons.add),),
  );
  }
}


