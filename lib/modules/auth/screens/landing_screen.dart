import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialauthenthication/modules/auth/screens/register_screen.dart';
import 'package:socialauthenthication/modules/auth/screens/temporary_logged_in_screen.dart';
import 'package:socialauthenthication/modules/auth/viewmodels/user_view_model.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context);

    if (_userViewModel.state == ViewState.IDLE) {
      if (_userViewModel.user == null) {
        return RegisterScreen();
      } else {
        print("_userViewModel.user.email  ${_userViewModel.user.email}");
        return TemporaryLoggedInScreen(userModel: _userViewModel.user);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
