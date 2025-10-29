import 'package:flutter/material.dart';

class InsertLink extends StatefulWidget {
  String title;
  String link;
  InsertLink({super.key, required this.title, required this.link});

  @override
  State<InsertLink> createState() => _InsertLinkState();
}

class _InsertLinkState extends State<InsertLink> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      appBar: AppBar(
        title: Text(
          "Insert Link",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 50,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 10,

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Enter Title"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(labelText: "Enter Link"),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (linkController.text.trim().isNotEmpty &&
                    Uri.tryParse(linkController.text)?.hasScheme == true &&
                    (Uri.parse(linkController.text).isAbsolute &&
                        Uri.parse(linkController.text).host.isNotEmpty &&
                        titleController.text.trim().isNotEmpty)) {
                  Navigator.pop(context, {
                    "title": titleController.text,
                    "link": linkController.text,
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter Valid URL and Title")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
