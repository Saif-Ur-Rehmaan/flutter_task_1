import 'package:flutter/material.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add User Screen"),),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text('Name'),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              label: Text('email'),
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text('Add Data'))
        ],
      ),
    );
  }
}
