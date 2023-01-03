import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive Database'),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: Hive.openBox('aman'),
            builder: (context, snapshot) {
              return Column(
                children: [
                  ListTile(
                    title: Text(snapshot.data!.get('name').toString()),
                    subtitle: Text(snapshot.data!.get('age').toString()),
                    trailing: IconButton(
                      onPressed: () {
                        // snapshot.data!.put('name', 'Sheikh Aman super Pro');

                        snapshot.data!.delete('name');
                        setState(() {});
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                  Text(snapshot.data!.get('name').toString()),
                  Text(snapshot.data!.get('age').toString()),
                  Text(snapshot.data!.get('map').toString()),
                ],
              );
            },
          ),
          FutureBuilder(
            future: Hive.openBox('name'),
            builder: (context, snapshot) {
              return Column(
                children: [
                  ListTile(
                    title: Text(snapshot.data!.get('youtube').toString()),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('aman');
          var box2 = await Hive.openBox('name');

          box2.put('youtube', 'Sheikh Aman');
          box.put('name', 'Sheikh Aman');
          box.put('age', '25');
          box.put('list', [1, 2, 3, 4]);
          box.put('map', {'1': 'one', '2': 'two'});

          print(box.get('name'));
          print(box.get('age'));
          print(box.get('list')[2]);
          print(box.get('map')['2']);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
