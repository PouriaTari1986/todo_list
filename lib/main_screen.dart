import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/main.dart';
import 'package:todo_list/model/to_do_model.dart';
import 'package:todo_list/todo_form_screen.dart';

final box = Hive.box<ToDoModel>(todoBox);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                TodoFormScreen(toDoModel: ToDoModel(
                   title: "",
                   desciption: '',
                   color: ToDoColor.black
                 )
                 )
              ,));
            }, icon: Icon(Icons.add_circle_rounded)),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "My ToDo Items",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<ToDoModel>>(
                valueListenable: box.listenable(),

                builder: (context, todoBox, widget) {
                  final todoList = todoBox.values.toList();
                  if (todoList.isEmpty) {
                    return Text("Empty");
                  } else {
                    return ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        final todo = todoList[index];
                        final key = todoBox.keyAt(index);
                        return ToDoItem(todo: todo, todoKey: key);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToDoItem extends StatelessWidget {
  const ToDoItem({super.key, this.todo, required this.todoKey});
  final ToDoModel? todo;
  final dynamic todoKey;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(todoKey),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => box.delete(todoKey),
      
      dismissThresholds: {DismissDirection.endToStart: 0.3},
      background: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete,color: Colors.white,),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
           MaterialPageRoute(builder:
            (context) => TodoFormScreen(toDoModel: todo!),));
        },
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(todo!.color.code).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.edit_note, size: 24,color: Color(todo!.color.code),),
                  SizedBox(
                  width: 4,),
                  Text(
                    todo!.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(todo!.color.code),
                    ),
                  ),
                ],
              ),
              if(todo!.desciption.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 28,top: 4),
                child: Text(
                  todo!.desciption,
                  textAlign: TextAlign.justify,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
             
              Divider()
            ],
          ),
        ),
      ),
      );
      
  
  }
}
