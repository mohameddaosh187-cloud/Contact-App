import 'package:contact_app/feature/view/widgets/custom_material_button.dart';
import 'package:contact_app/feature/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

class NewContactScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDark;
  const NewContactScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDark,
  });

  @override
  State<NewContactScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<NewContactScreen> {
  String dropdownButtonValue = "Pending";
  var name = TextEditingController();
  var phone = TextEditingController();
  int colorSelected = 4283215696;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Contact",
          style: TextStyle(fontSize: 25, fontWeight: .bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            crossAxisAlignment: .start,
            children: [
              CustomTextFormField(
                label: "Name",
                hint: "Enter Name",
                controller: name,
              ),
              CustomTextFormField(
                label: "Phone Number",
                hint: "Enter Phone Number",
                controller: phone,
              ),
              SizedBox(height: 50),
              CustomMaterialButton.name(onPressed: () async {}, text: "Save"),
            ],
          ),
        ),
      ),
    );
  }
}
