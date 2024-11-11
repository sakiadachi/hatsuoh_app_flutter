import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hatsuoh App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class CollectionModel extends ChangeNotifier {
  final List<String> _collections = ['Hoge', 'Boo', 'Booyah'];
  UnmodifiableListView<String> get collections =>
      UnmodifiableListView(_collections);

  void add(String str) {
    _collections.add(str);
    notifyListeners();
  }

  void removeAll() {
    _collections.clear();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CollectionModel(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Collections'),
          ),
          body: Center(
            child: Consumer<CollectionModel>(
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (var i in value.collections) Text(i),
                    ElevatedButton(
                        onPressed: () {
                          Provider.of<CollectionModel>(context, listen: false)
                              .add('Its a new word');
                        },
                        child: const Text('add'))
                  ],
                );
              },
            ),
          )),
    );
  }
}
