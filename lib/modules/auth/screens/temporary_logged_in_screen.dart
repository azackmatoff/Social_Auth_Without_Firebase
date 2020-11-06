import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:provider/provider.dart';
import 'package:socialauthenthication/modules/auth/constants/api.dart';
import 'package:socialauthenthication/modules/auth/constants/color_branding.dart';
import 'package:socialauthenthication/modules/auth/models/user_model.dart';
import 'package:socialauthenthication/modules/auth/viewmodels/user_view_model.dart';

class TemporaryLoggedInScreen extends StatefulWidget {
  final UserModel userModel;

  const TemporaryLoggedInScreen({
    Key key,
    this.userModel,
  }) : super(key: key);

  @override
  _TemporaryLoggedInScreenState createState() =>
      _TemporaryLoggedInScreenState();
}

class _TemporaryLoggedInScreenState extends State<TemporaryLoggedInScreen> {
  final vkPlugin = VKLogin(debug: true);
  @override
  void initState() {
    super.initState();
    _initVKSdk();
  }

  void _initVKSdk() async {
    await vkPlugin.initSdk(APIKEYS.vkApiKey);
  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Temporary Logged In Screen'),
          backgroundColor: ColorBranding.greyDark,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
            child: Builder(
              builder: (context) => Center(
                child: Column(
                  children: <Widget>[
                    OutlineButton(
                      child: Text('Log Out'),
                      onPressed: () => _userViewModel.signOut(
                        context,
                        vkPlugin,
                      ),
                    ),
                    if (_userViewModel != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _buildUserInfo(widget.userModel),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(UserModel userModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('User: '),
        Text(
          '${userModel.firstName} ${userModel.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'UserID: ${userModel.userID}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (userModel.profileURL != null) Text("Email: ${userModel.email}"),
        if (userModel.profileURL != null) Image.network(userModel.profileURL),
        Text('AccessToken: '),
        Container(
          child: Text(
            userModel.accesToken,
            softWrap: true,
          ),
        ),
        Text('Created: ${userModel.accesToken}'),
        // Text('Expires in: ${accessToken.expiresIn}'),
      ],
    );
  }
}
