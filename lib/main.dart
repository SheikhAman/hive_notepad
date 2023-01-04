import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'home_screen.dart';
import 'models/notes_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // directory create korlam
  var directory = await getApplicationDocumentsDirectory();
  //1) hive initialize korlam sei directory te
  Hive.init(directory.path);

  // adapter register korlam  abong model generate hoye gese tai akhun data parse korbo
  Hive.registerAdapter(NotesModelAdapter());

// akta file create korlam jar type hoche notesmodel
  await Hive.openBox<NotesModel>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
