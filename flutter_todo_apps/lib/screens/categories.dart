import 'package:flutter/material.dart';
import 'package:flutter_todo_apps/repository/database_connection.dart';
import 'package:flutter_todo_apps/screens/home_screen.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Map<String, dynamic>> _dataList = [];

  _addItems(int? id, String? title, String? description) {
    TextEditingController titleController = TextEditingController();
    TextEditingController desController = TextEditingController();
    if (id != null) {
      titleController.text = title!;
      desController.text = description!;
    }
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
            title: const Text('Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Write a Title',
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    controller: desController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: 'Write a description',
                      labelText: 'Description',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var title = titleController.text.toString();
                      var des = desController.text.toString();
                      if (id == null) {
                        SQLHelper.insertData(title, des,"").then((value) => {
                              if (value != -1)
                                {
                                  print("Data inserted Successfully"),
                                }
                              else
                                {
                                  print("failed to insert"),
                                }
                            });
                      }
                    },
                    child: const Text("add"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  getAllData() async {
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: RaisedButton(
          onPressed: () => {
            getAllData(),
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const HomeScreen())),
          },
          elevation: 0.0,
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          color: Colors.blue,
        ),
      ),
      body: const Center(
        child: const Text('Welcome to Categories Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItems(null, null, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}