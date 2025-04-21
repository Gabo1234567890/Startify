import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:startify/pages/contracts_page.dart';
import 'package:startify/widgets/app_bar_widget_nologin.dart';
import 'package:startify/widgets/plus_button_widget.dart';
import 'package:startify/widgets/edit_button_widget.dart';

class MyStartupPage extends StatefulWidget {
  const MyStartupPage({super.key});

  @override
  State<MyStartupPage> createState() => _MyStartupPageState();
}

class _MyStartupPageState extends State<MyStartupPage> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetNoLogIn(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Text(
                      "STARTUP'S NAME",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 100),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: PlusButton(onPressed: _pickImage),
                  ),
                ],
              ),

              // Contract Button
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ContractsPage()),
                    );
                  },
                  child: const Text(
                    "300\$ / 600\$",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Images Grid
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildImageBox(_pickedImage),
                      _buildImageBox(null),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [_buildImageBox(null)],
                  ),
                ],
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            "DESCRIPTION",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 180),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: EditButtonWidget(),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Mobile application that connects entrepreneurs and investors.',
                      ),
                    ),
                  ],
                ),
              ),

              // Documents Section
              _buildDocumentSection("1. Document's name"),
              _buildDocumentSection("2. Document's name"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageBox(File? imageFile) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 165,
        height: 165,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).splashColor, width: 3),
          image:
              imageFile != null
                  ? DecorationImage(
                    image: FileImage(imageFile),
                    fit: BoxFit.cover,
                  )
                  : const DecorationImage(
                    image: AssetImage('lib/assets/idea_placeholder.png'),
                    fit: BoxFit.cover,
                  ),
        ),
      ),
    );
  }

  Widget _buildDocumentSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 160),
                const Icon(Icons.circle_outlined),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buildDocumentBox(), _buildAddDocumentButton()],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8),
            child: Text(
              'More information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 4),
            child: Text(
              'This document is...',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).splashColor, width: 3),
        ),
      ),
    );
  }

  Widget _buildAddDocumentButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).splashColor, width: 3),
        ),
        child: ElevatedButton(
          onPressed: () {
            // Add document functionality here
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 50),
              Text(
                'Add your document.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
