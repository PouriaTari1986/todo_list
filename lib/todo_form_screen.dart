


import 'package:flutter/material.dart';
import 'package:todo_list/main_screen.dart';
import 'package:todo_list/model/to_do_model.dart';

late ToDoColor _selectedColor;
// ignore: must_be_immutable
class TodoFormScreen extends StatelessWidget {
   TodoFormScreen({super.key,required this.toDoModel});


  ToDoModel toDoModel;

  @override
  Widget build(BuildContext context) {

    _selectedColor = toDoModel.color;
    final titleController = TextEditingController(text: toDoModel.title);
    final descriptionController = TextEditingController(text: toDoModel.desciption);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("ToDo Form"),
       leading: IconButton(
        onPressed: ()=>Navigator.pop(context),
        icon: Icon(Icons.keyboard_arrow_left))
       ), 
       body: Padding(padding: EdgeInsets.symmetric(horizontal: 12),
       child: Column(
        children: [
         
          _TodoColorSelector(),
          TextField(
            controller: titleController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(hintText: "title"),
          ),
          SizedBox(height: 12,),
          TextField(
            controller: descriptionController,
            textInputAction: TextInputAction.newline,
            maxLines: 8,
            decoration: InputDecoration(hintText: "desciption"),
          ),

        ],
       ),),
       floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50) ),
        
        onPressed: (){
          if(titleController.text.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Complete all tehe Fiels ")));
          }
          else{
          toDoModel.title = titleController.text.trim();
          toDoModel.desciption = descriptionController.text.trim();
          toDoModel.color = _selectedColor;
          if (toDoModel.isInBox) {
            toDoModel.save();
          } else {
            box.add(toDoModel);
          }
          Navigator.pop(context);
        }},
        child: Icon(Icons.save) ,),
        
    )
    );
  }
}

class _TodoColorSelector extends StatefulWidget {
  

  @override
  State<_TodoColorSelector> createState() => _TodoColorSelectorState();
}

class _TodoColorSelectorState extends State<_TodoColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
      
        children: [
          ColorItem(onTap: () { setState(() {
            _selectedColor = ToDoColor.blue;
          }); }, 
          isSelected: _selectedColor==ToDoColor.blue, 
          colorCode: ToDoColor.blue.code,),
      
          ColorItem(onTap: () { setState(() {
            _selectedColor = ToDoColor.black;
          }); }, 
          isSelected: _selectedColor==ToDoColor.black, 
          colorCode: ToDoColor.black.code,),
      
          ColorItem(onTap: () { setState(() {
            // ignore: unrelated_type_equality_checks
            _selectedColor = ToDoColor.red;
          }); }, 
          isSelected: _selectedColor==ToDoColor.red, 
          colorCode: ToDoColor.red.code,),
      
          ColorItem(onTap: () { setState(() {
            // ignore: unrelated_type_equality_checks
            _selectedColor = ToDoColor.green;
          }); }, 
          isSelected: _selectedColor==ToDoColor.green, 
          colorCode: ToDoColor.green.code,),
        ],
      ),
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key, required this.onTap, required this.isSelected, required this.colorCode,
  });
  final Function() onTap;
  final bool isSelected;
  final int colorCode;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
         shape: BoxShape.circle,
         color: Color(colorCode),
         
        ),
        // ignore: unrelated_type_equality_checks
        child: isSelected? Icon(Icons.check,color: Colors.white,):null
      ),
    );
  }
}