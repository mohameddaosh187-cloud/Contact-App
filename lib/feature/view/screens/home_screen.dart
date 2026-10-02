// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_app/core/helper/app_dialog.dart';
import 'package:contact_app/feature/data/firebase/firebase_service.dart';
import 'package:contact_app/feature/data/model/contact_user.dart';
import 'package:flutter/material.dart';

import 'package:contact_app/core/routes/app_routes.dart';
import 'package:contact_app/feature/view/screens/new_contact_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDark,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactUser> users = [];

  @override
  @override
  void initState() {
    super.initState();
    getAllContact();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mohamed Contacts',
          style: TextStyle(fontSize: 25, fontWeight: .bold),
        ),
        actions: [
          IconButton(
            onPressed: widget.onThemeChanged,
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => CardPerson(
          title: users[index].name ?? "",
          subtitle: users[index].phone ?? "",
          onTap: () async {
            AppDialog.showLoading(context);
            await AppFirebaseService.delete(users[index].id);
            Navigator.pop(context);
            users.removeAt(index);
            setState(() {});
          },
          update: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewContactScreen(
                  user: users[index],
                  onThemeChanged: widget.onThemeChanged,
                  isDark: widget.isDark,
                ),
              ),
            );
            getAllContact();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewContactScreen(
                onThemeChanged: widget.onThemeChanged,
                isDark: widget.isDark,
              ),
            ),
          );
          getAllContact();
        },
        child: Text(
          "Add",
          style: TextStyle(
            fontSize: 16,
            fontWeight: .bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void getAllContact() async {
    users = await AppFirebaseService.getAllData();
    setState(() {});
  }
}

class CardPerson extends StatelessWidget {
  CardPerson({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.update,
  });
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final void Function()? update;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: update,
      child: Card(
        margin: EdgeInsets.all(16),
        child: ListTile(
          title: Text(title, style: TextStyle(fontSize: 20)),
          subtitle: Text(subtitle, style: TextStyle(fontSize: 16)),
          trailing: InkWell(
            onTap: onTap,
            child: Icon(Icons.delete, size: 30, color: Colors.red),
          ),
        ),
      ),
    );
  }
}
