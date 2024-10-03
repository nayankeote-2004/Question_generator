import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:path_provider/path_provider.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({Key? key}) : super(key: key);

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final List<Map<String, String>> docs = [
    {'name': 'Question Paper', 'path': 'assets/Generated_Question_Paper1.docx'},
    {'name': 'Answer Key', 'path': 'assets/Generated_Question_Paper2.docx'},
  ];

  String? selectedDoc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a document to preview and download:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDoc = docs[index]['name'];
                      });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                          color: selectedDoc == docs[index]['name']
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(docs[index]['name']!),
                            const Icon(Icons.download, color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            if (selectedDoc != null)
              ElevatedButton(
                onPressed: () {
                  _downloadFile(selectedDoc!);
                },
                child: const Text('Download Document'),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadFile(String docName) async {
    try {
      // Get the file path from the docs list
      final doc = docs.firstWhere((doc) => doc['name'] == docName);
      final filePath = doc['path'];

      // Load file from assets
      final ByteData data = await rootBundle.load(filePath!);
      final Uint8List bytes = data.buffer.asUint8List();

      // Get the Downloads directory
      final directory = await getDownloadsDirectory();
      if (directory != null) {
        final String fullPath = '${directory.path}/$docName.docx';
        final File file = File(fullPath);

        // Write the file to the system
        await file.writeAsBytes(bytes);

        // Show confirmation message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('File saved at $fullPath'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to get downloads directory'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return await getApplicationDocumentsDirectory();
    } else {
      return await getExternalStorageDirectory();
    }
  }
}
