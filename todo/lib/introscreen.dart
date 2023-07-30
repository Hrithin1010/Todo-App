import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/Home.dart';

void main()async{
    await Hive.initFlutter();
  Hive.openBox('todo');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: introscreen(),
  ));
}

class introscreen extends StatefulWidget {
  const introscreen({super.key});

  @override
  State<introscreen> createState() => _introscreenState();
}

class _introscreenState extends State<introscreen> {

@override
  void initState() {
    todofuction();
    super.initState();
  }

  Future<void>todofuction()async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwu-PoDKsazxzc3IUxcx17ZpOy0EARw7M60Q&usqp=CAU")
      ),
    );
  }
}