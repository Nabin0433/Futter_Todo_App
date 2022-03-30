import 'package:flutter/material.dart';
import 'package:test/shared/Route/Router.dart';

void main() {
  runApp(MyApp(router: MyRoute()));
}

class MyApp extends StatelessWidget {
  final MyRoute router;

  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generateRoutes,
    );
  }
}
