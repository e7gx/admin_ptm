import 'package:flutter/material.dart';
import '../admin.dart';
import 'package:firedart/firedart.dart';

const apiKey = 'AIzaSyA6klB5lr3NPpMls_RDAOawnLiqR_EE8J4';
const projectId = 'flutterdatabase-7e044';

void main() {
  Firestore.initialize(projectId);
  runApp(const Admin());
}

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  CollectionReference ptm = Firestore.instance.collection('IT_Reports');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(
        title: 'الصفحة الرئيسية',
      ),
    );
  }
}
