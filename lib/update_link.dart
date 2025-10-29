import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  String name;
  dynamic linkbody;
  UpdatePage({super.key, required this.name, required this.linkbody});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      appBar: AppBar(
        title: Text(
          "Update Link",
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
            Text(widget.name),
            Text(widget.linkbody),
            SizedBox(height: 20),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleController,

                  decoration: InputDecoration(labelText: "Update Title"),
                ),
              ),
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(labelText: "Update Link"),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                linkController.text.isEmpty
                    ? linkController.text = widget.linkbody
                    : linkController.text;
                titleController.text.isEmpty
                    ? titleController.text = widget.name
                    : titleController.text;

                if (Uri.tryParse(linkController.text)?.hasScheme == true &&
                    (Uri.parse(linkController.text).isAbsolute &&
                        Uri.parse(linkController.text).host.isNotEmpty)) {
                  Navigator.pop(context, {
                    "updated_title": titleController.text,
                    "updated_link": linkController.text,
                  });
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Enter Valid URL ")));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'Update',
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
