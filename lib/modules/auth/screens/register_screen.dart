import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:provider/provider.dart';
import 'package:socialauthenthication/modules/auth/constants/api.dart';
import 'package:socialauthenthication/modules/auth/constants/color_branding.dart';
import 'package:socialauthenthication/modules/auth/models/user_model.dart';
import 'package:socialauthenthication/modules/auth/screens/terms_and_conditions.dart';
import 'package:socialauthenthication/modules/auth/viewmodels/user_view_model.dart';
import 'package:socialauthenthication/modules/widgets/platform_alert_dialog.dart';
import 'package:socialauthenthication/modules/widgets/social_button.dart';

class RegisterScreen extends StatefulWidget {
  final vkPlugin = VKLogin(debug: true);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool checkBoxValue = false;

  @override
  void initState() {
    _initVKSdk();
    super.initState();
  }

  void _initVKSdk() async {
    await widget.vkPlugin.initSdk(APIKEYS.vkApiKey);
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (builder) {
        return Container(
          height: 250.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorBranding.white,
                ColorBranding.greySilver,
                ColorBranding.greyDark,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  size: 40.0,
                  color: ColorBranding.blueBelizeHole,
                ),
                SizedBox(height: 20.0),
                Text(
                  "Пожалуйста, прочитайте и принимайте условия пользовательского соглашения!",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ignore: unused_element
  void _signInWithYandex(BuildContext context) async {
    // final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    // try {
    //   UserModel _user = await _userViewModel.signInWithFacebook();
    // } on PlatformException catch (e) {
    //   print("signInWithFacebook Error :" + e.message.toString());
    // }
  }

  void _signInWithVK(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      UserModel _user =
          await _userViewModel.signInWithVK(context, widget.vkPlugin);
    } on PlatformException catch (e) {
      print("_signInWithVK Error on Register page:" + e.message.toString());
      await PlatformAlertDialog(
        subject: "Авторизация не удалась",
        content: "Ошибка: ${e.toString()}",
        mainButtonText: "OK",
      ).choosePlatformToShowDialog(context);
    }
  }

  void _signInWithFacebook(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      UserModel _user = await _userViewModel.signInWithFacebook();
    } on PlatformException catch (e) {
      print("signInWithFacebook Error :" + e.message.toString());
    }
  }

  void _signInWithTelegram(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      UserModel _user = await _userViewModel.signInWithFacebook();
    } on PlatformException catch (e) {
      print("signInWithFacebook Error :" + e.message.toString());
    }
  }

  void _signInWithInstagram(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);

    try {
      UserModel _user = await _userViewModel.signInWithFacebook();
    } on PlatformException catch (e) {
      print("signInWithFacebook Error :" + e.message.toString());
    }
  }

  _buildCheckboxAndText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Checkbox(
            activeColor: ColorBranding.blueBelizeHole,
            value: checkBoxValue,
            onChanged: (bool value) {
              setState(() {
                checkBoxValue = value;
              });
              print("checkbox value $checkBoxValue");
            },
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: RichText(
                maxLines: 4,
                text: TextSpan(
                  text: 'Я прочитал и принимаю условия ',
                  style: TextStyle(color: ColorBranding.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'ползовательского соглашения ',
                      style: TextStyle(
                        color: ColorBranding.blueBelizeHole,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsAndConditions(),
                                fullscreenDialog: true),
                          );
                        },
                    ),
                    TextSpan(
                      text: 'и обработки персональных данных',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSocialButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialButton(
            imageAsset: "assets/icons/yandex.png",
            height: 50.0,
            width: 50.0,
            onPressed: () => checkBoxValue
                ? _signInWithYandex(context)
                : _modalBottomSheetMenu(context),
          ),
          SocialButton(
            imageAsset: "assets/icons/vk.png",
            height: 50.0,
            width: 50.0,
            onPressed: () => checkBoxValue
                ? _signInWithVK(context)
                : _modalBottomSheetMenu(context),
          ),
          SocialButton(
              imageAsset: "assets/icons/facebook.png",
              height: 50.0,
              width: 50.0,
              onPressed: () => checkBoxValue
                  ? _signInWithFacebook(context)
                  : _modalBottomSheetMenu(context)),
          SocialButton(
            imageAsset: "assets/icons/telegram.png",
            height: 50.0,
            width: 50.0,
            onPressed: () => checkBoxValue
                ? _signInWithTelegram(context)
                : _modalBottomSheetMenu(context),
          ),
          SocialButton(
            imageAsset: "assets/icons/instagram.png",
            height: 50.0,
            width: 50.0,
            onPressed: () => checkBoxValue
                ? _signInWithInstagram(context)
                : _modalBottomSheetMenu(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorBranding.white,
                ColorBranding.greySilver,
                ColorBranding.greyConcrete,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Регистрация",
                style: TextStyle(fontSize: 40.0),
              ),
              SizedBox(height: 20.0),
              Text(
                "через социальные сети",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              _buildCheckboxAndText(),
              SizedBox(height: 30.0),
              _buildSocialButtons(),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
