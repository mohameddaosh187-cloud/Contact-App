import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/core/helper/app_dialog.dart';
import 'package:contact_app/feature/data/firebase/firebase_service.dart';
import 'package:contact_app/feature/data/model/contact_user.dart';
import 'package:contact_app/feature/view/widgets/custom_material_button.dart';
import 'package:contact_app/feature/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import 'dart:developer';

class NewContactScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDark;
  final ContactUser? user;
  const NewContactScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDark,
    this.user,
  });

  @override
  State<NewContactScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<NewContactScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user?.name);
    phoneController = TextEditingController(text: widget.user?.phone);
  }

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
                controller: nameController,
              ),
              CustomTextFormField(
                label: "Phone Number",
                hint: "Enter Phone Number",
                controller: phoneController,
              ),
              SizedBox(height: 50),
              CustomMaterialButton.name(
                onPressed: widget.user == null
                    ? () async {
                        var name = nameController.text;
                        var phone = phoneController.text;
                        AppDialog.showLoading(context);
                        try {
                          AppFirebaseService.addUser(
                            ContactUser(name: name, phone: phone),
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } catch (e) {
                          Navigator.of(context).pop();
                          AppDialog.showError(context, e.toString());
                        }
                      }
                    : () {
                        try {
                          AppFirebaseService.update(
                            ContactUser(
                              name: nameController.text,
                              phone: phoneController.text,
                              id: widget.user?.id,
                            ),
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } catch (e) {
                          Navigator.of(context).pop();
                          AppDialog.showError(context, e.toString());
                        }
                      },
                text: widget.user == null
                    ? "Add New Contact"
                    : "Update Contact",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
