import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notepad/models/notes_model.dart';

import 'boxes/boxes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database'),
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100.0,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              data[index].title.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  _editDialog(
                                      data[index],
                                      data[index].title.toString(),
                                      data[index].description.toString());
                                },
                                child: Icon(Icons.edit)),
                            SizedBox(
                              width: 15.0,
                            ),
                            InkWell(
                              onTap: () {
                                delete(data[index]);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Text(data[index].description.toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: 'Enter title', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: 'Enter description',
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
                onPressed: () {
                  final data = NotesModel(
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  final box = Boxes.getData();
                  // hive e data add korlam list akare
                  box.add(data);
                  // save korlam
                  // data.save();
                  print(box);
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                },
                child: Text('Add')),
          ],
        );
      },
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> _editDialog(
      NotesModel notesModel, String title, String description) async {
    titleController.text = title;
    descriptionController.text = description;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Notes'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: 'Enter title', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: 'Enter description',
                      border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
                onPressed: () {
                  notesModel.title = titleController.text.toString();
                  notesModel.description =
                      descriptionController.text.toString();
                  notesModel.save();
                  descriptionController.clear();
                  titleController.clear();
                  Navigator.pop(context);
                },
                child: Text('Edit')),
          ],
        );
      },
    );
  }
}
