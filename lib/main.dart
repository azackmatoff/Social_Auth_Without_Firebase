import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialauthenthication/modules/auth/screens/landing_screen.dart';
import 'locator.dart';
import 'modules/auth/viewmodels/user_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      //builder is now create
      create: (context) => UserViewModel(),
      child: MaterialApp(
        title: 'Flutter Social Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LandingScreen(),
      ),
    );
  }
}
