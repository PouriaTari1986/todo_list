import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/main_screen.dart';
import 'package:todo_list/model/to_do_model.dart';


const String todoBox = 'todo-box';


Future<void> main () async {
  WidgetsFlutterBinding.ensureInitialized();

Directory directory = await getApplicationDocumentsDirectory();
Hive.init(directory.path);

Hive
  ..registerAdapter(ToDoModelAdapter())
  ..registerAdapter(ToDoColorAdapter());

await Hive.openBox<ToDoModel> (todoBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(centerTitle: true,),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle:  TextStyle(color: Colors.black12) ,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.blue.withValues(alpha: .5))
          ),
        )
      ),
      home: MainScreen(),
    );
  }
}

