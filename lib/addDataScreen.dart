import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  submit() {
    final DatabaseReference database = FirebaseDatabase.instance.ref();

    var k=database.child('users').push().key;
    database.child('users/$k').set({
      'name': nameController.text,
      'email': emailController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User Screen"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              label: Text('Name'),
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              label: Text('email'),
            ),
          ),
          ElevatedButton(onPressed: submit, child: Text('Add Data'))
        ],
      ),
    );
  }
}
