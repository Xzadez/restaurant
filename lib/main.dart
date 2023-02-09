import 'package:flutter/material.dart';

import 'router_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: Routers.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
