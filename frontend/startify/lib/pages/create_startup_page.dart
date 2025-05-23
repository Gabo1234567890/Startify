import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:startify/services/startup_service.dart';
import 'dart:io';
import 'package:startify/widgets/app_bar_widget_nologin.dart';
import 'package:startify/widgets/plus_button_widget.dart';

class CreateStartupPage extends StatefulWidget {
  const CreateStartupPage({super.key});

  @override
  State<CreateStartupPage> createState() => _CreateStartupPageState();
}

class _CreateStartupPageState extends State<CreateStartupPage> {
  bool _isEditing = false;
  final TextEditingController _controller = TextEditingController();

  bool _isEditingDescription = false;
  final TextEditingController _descriptionController = TextEditingController();

  bool _isEditingAmount = false;
  final TextEditingController _amountController = TextEditingController(
    text: "0",
  );

  List<File> _images = [];

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  final List<String> _statusOptions = [
    "Sole Trader",
    "Limited Liability Company (LLC)",
    "Joint-stock Company (JSC)",
  ];
  String _selectedStatus = "Sole Trader";

  @override
  void dispose() {
    _controller.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgetNoLogIn(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          // wrapped in scroll view just in case
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Create Startup",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Name: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child:
                        _isEditing
                            ? TextField(
                              controller: _controller,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Enter startup name...",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            )
                            : Text(
                              _controller.text,
                              style: TextStyle(fontSize: 18),
                            ),
                  ),
                  IconButton(
                    icon: Icon(_isEditing ? Icons.check : Icons.edit),
                    onPressed: _toggleEditing,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child:
                            _isEditingDescription
                                ? TextField(
                                  controller: _descriptionController,
                                  autofocus: true,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Enter startup description...",
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8),
                                    border: OutlineInputBorder(),
                                  ),
                                )
                                : Text(
                                  _descriptionController.text,
                                  style: TextStyle(fontSize: 16),
                                ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isEditingDescription ? Icons.check : Icons.edit,
                        ),
                        onPressed: () {
                          setState(() {
                            _isEditingDescription = !_isEditingDescription;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Request Amount: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child:
                        _isEditingAmount
                            ? TextField(
                              controller: _amountController,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter startup requested amount...",
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            )
                            : Text(
                              _amountController.text,
                              style: TextStyle(fontSize: 18),
                            ),
                  ),
                  IconButton(
                    icon: Icon(_isEditingAmount ? Icons.check : Icons.edit),
                    onPressed: () {
                      setState(() {
                        _isEditingAmount = !_isEditingAmount;
                      });
                    },
                  ),
                ],
              ),
              Text(
                "Desired startup status:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedStatus,
                isExpanded: true,
                items:
                    _statusOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Images:",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 210),
                  PlusButton(onPressed: _pickImage),
                ],
              ),
              SizedBox(height: 15),
              Center(
                child: Wrap(
                  spacing: 30,
                  runSpacing: 8,
                  children:
                      _images
                          .map(
                            (file) => ClipRRect(
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // <-- Set the roundness here
                              child: Image.file(
                                file,
                                width: 149,
                                height: 191,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              try {
                await StartupService().createStartup(
                  name: _controller.text,
                  description: _descriptionController.text,
                  goalAmount: int.tryParse(_amountController.text) ?? 0,
                );
                Navigator.pop(context, true);
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to create startup')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text("Create", style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
