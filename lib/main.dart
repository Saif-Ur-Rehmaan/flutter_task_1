import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'addDataScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void openAddDataModal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddDataScreen()),
    );
  }

  Future<List<Map<String, dynamic>>> getUsers(
      DatabaseReference database) async {
    try {
      var res = await database.child('users').get();
      var users = res.value;

      if (users != null && users is Map) {
        return users.values
            .map((user) => Map<String, dynamic>.from(user as Map))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference database = FirebaseDatabase.instance.ref();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getUsers(database),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          } else {
            final userList = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Edit')),
                  DataColumn(label: Text('Delete')),
                ],
                rows: userList.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Text(user['name'] ?? 'Unknown')),
                      DataCell(Text(user['email'] ?? 'Unknown')),
                      DataCell(IconButton(
                        onPressed: () {
                          // Edit logic here
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      )),
                      DataCell(IconButton(
                        onPressed: () {
                          // Delete logic here
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddDataModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
