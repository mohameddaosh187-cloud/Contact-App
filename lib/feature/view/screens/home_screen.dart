import 'package:contact_app/core/routes/app_routes.dart';
import 'package:contact_app/feature/view/screens/new_contact_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeChanged;
  final bool isDark;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDark,
  });

  @override
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
            onPressed: onThemeChanged,
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),

      body: ListView.builder(
        itemBuilder: (context, index) =>
            CardPerson(title: "Ali$index", subtitle: "01036948537$index"),
        itemCount: 20,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewContactScreen(
                onThemeChanged: onThemeChanged,
                isDark: isDark,
              ),
            ),
          );
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
}

class CardPerson extends StatelessWidget {
  const CardPerson({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 20)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 16)),
        trailing: Icon(Icons.person, size: 30, color: Colors.blue),
      ),
    );
  }
}
