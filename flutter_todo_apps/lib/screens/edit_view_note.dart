import 'package:flutter/material.dart';
import 'package:flutter_todo_apps/screens/note_view.dart';


class EditViewNote extends StatelessWidget {
  var description;

  var title;

  EditViewNote({Key? key, this.title, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ViewNoteScreen(
                                title: title,
                                description: description,
                              );
                            },
                          ));
                        },
                        icon: const Icon(
                          Icons.save,
                          color: Colors.blue,
                        ),
                      )),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 1,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 2,
              decoration: InputDecoration(
                labelText: '$title',
              ),
            ),
            SingleChildScrollView(
              child: TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: '$description',
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
