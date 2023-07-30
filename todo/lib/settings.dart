import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()async{
    await Hive.initFlutter();
  Hive.openBox('todo');
}

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 84, 150, 72),
        title: Text('Settings',style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255),fontSize: 25),),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person,color: Colors.black,),
            title: Text('Profile',style: TextStyle(color: Colors.black),),
            onTap: () {
              // Handle profile settings
            },
          ),
         SizedBox(height: 15,),
          
          ListTile(
            leading: Icon(Icons.help,color: Colors.black,),
            title: Text('Help',style: TextStyle(color: Colors.black),),
            onTap: () {
              // Handle help settings
            },
          ),

         
        ],
      ),
    );
  }
}
