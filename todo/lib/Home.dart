import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/addingcontent.dart';
import 'package:todo/settings.dart';
import 'package:todo/viewpage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.openBox('todo');
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
  // Wrap your app
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> datas = [];
  final Hive_Box2 = Hive.box('todo');

  @override
  void initState() {
    readTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
              child: ListTile(
                title: Center(
                    child: Text(
                  "Home",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image:NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRip5-dpryOtI0BRbRmyprR6kLGFgBlvzgTA&usqp=CAU'),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  "Today's Task",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    final mytask = datas[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => View_task(
                                      title: mytask['title'],
                                      description: mytask['description'],
                                    ))),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(blurRadius: 2)]),
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        mytask['title'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      mytask['description'],
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    deletetask(mytask['id']);
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 84, 150, 72),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Add_content()));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => settings()));
              },
              icon: Icon(Icons.settings_applications),
            ),
            label: 'Settings'),
      ]),
    );
  }

  void readTask() {
    final TaskFromHive = Hive_Box2.keys.map((key) {
      final values = Hive_Box2.get(key);
      return ({
        'id': key,
        'title': values['title'],
        'description': values['description']
      });
    });
    setState(() {
      datas = TaskFromHive.toList();
    });
  }

  Future<void> deletetask(id) async {
    await Hive_Box2.delete(id);
    readTask();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Successfully deleted")));
  }
}
