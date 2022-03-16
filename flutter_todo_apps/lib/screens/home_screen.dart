import 'package:flutter/material.dart';
import 'package:flutter_todo_apps/helpers/drawer_navigator.dart';
import 'package:flutter_todo_apps/repository/database_connection.dart';
import 'package:flutter_todo_apps/screens/note_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _dataList = [];
  String? userID;

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
              ElevatedButton(
                onPressed: () {
                  var title = titleController.text.toString();
                  var des = desController.text.toString();
                  if (id == null) {
                    SQLHelper.insertData(title, des,userID!).then((value) => {
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
                  getAllData();
                  Navigator.pop(context);
                },
                child: const Text("add"),
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
                ],
              ),
            ),
          );
        });
  }

  getAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userID = sharedPreferences.getString("userId");

    if(userID != null){
      var List = await SQLHelper.getAllData(userID!);
      setState(() {
        _dataList = List;
      });
    }

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
        title: const Text('Todolist Sqflite'),
      ),
      drawer: const DrawerNavigaton(),
      body: ListView.builder(
        itemCount: _dataList.length,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNoteScreen(
                        title: _dataList[position]["title"].toString(),
                        description:
                            _dataList[position]["description"].toString()),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4, left: 2, right: 2),
              child: Card(
                color: Colors.red[200],
                elevation: 3,
                child: Slidable(
                  endActionPane: ActionPane(
                    extentRatio: 0.4,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext) {},
                        backgroundColor: Colors.blue,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (BuildContext) {
                          SQLHelper.deleteData(_dataList[position]["id"]);
                          getAllData();
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      _dataList[position]["title"].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _dataList[position]["description"].toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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