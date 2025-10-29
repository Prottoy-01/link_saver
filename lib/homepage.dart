import 'package:flutter/material.dart';
import 'package:save_link/insert_link.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:save_link/update_link.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> links = [];
  final box = Hive.box("data");

  @override
  void initState() {
    getData();
    super.initState();
  }

  void putData() {
    box.put('data', links);
  }

  void getData() {
    final results = box.get('data', defaultValue: []);
    setState(() {
      links = (results as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
      //links.add(results);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      appBar: AppBar(
        elevation: 50,
        backgroundColor: Colors.green,
        title: Text(
          'Save Link',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 30,
                  shadowColor: Colors.green,
                  child: ListTile(
                    title: Text(
                      links[index]['title'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(links[index]['link']),

                    onTap: () => launchUrl(Uri.parse(links[index]['link'])),

                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 1, child: Text('Edit')),
                        PopupMenuItem(value: 2, child: Text('Delete')),
                      ],
                      onSelected: (value) async {
                        if (value == 1) {
                          final updateResult = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePage(
                                name: links[index]['title'],
                                linkbody: links[index]['link'],
                              ),
                            ),
                          );
                          if (updateResult != null) {
                            setState(() {
                              links[index]['title'] =
                                  updateResult['updated_title'];
                              links[index]['link'] =
                                  updateResult['updated_link'];
                              putData();
                            });
                          }
                        } else if (value == 2) {
                          setState(() {
                            links.removeAt(index);
                            putData();
                          });
                        }
                      },
                    ),
                  ),
                );
              },
              //separatorBuilder: (context, index) =>
              // Divider(color: Colors.black),
              itemCount: links.length,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsertLink(title: '', link: ''),
            ),
          );
          if (result != null) {
            setState(() {
              links.add(result);
              putData();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
