import 'package:flutter/material.dart';
import 'package:socialauthenthication/modules/auth/constants/color_branding.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Условия соглашения"),
        backgroundColor: ColorBranding.greyConcrete,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          height: MediaQuery.of(context).size.height * 1.3,
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
            children: [
              SizedBox(height: 20.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sagittis quam at lectus rutrum facilisis. Donec vehicula urna odio, quis consectetur nisi mollis venenatis. Nunc dolor arcu, sodales eu urna at, aliquet interdum ligula. Donec cursus iaculis purus in rhoncus. Suspendisse aliquam erat enim, non placerat quam sodales quis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed tincidunt sapien laoreet neque imperdiet, ut rhoncus massa scelerisque. Integer vestibulum neque at nulla laoreet, at tempus augue tempor. Duis imperdiet molestie est. Nunc consectetur ornare arcu ac aliquet.",
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Text(
                  "In euismod dui in magna viverra aliquet. Nunc feugiat ligula non ipsum viverra varius. Donec scelerisque aliquam libero, sit amet ultrices mi condimentum at. Maecenas at feugiat nibh. Phasellus posuere iaculis dictum. Morbi accumsan augue blandit ex cursus commodo. Mauris elementum massa sed risus rhoncus egestas. Pellentesque iaculis facilisis purus, commodo suscipit dui. Nulla facilisi. Sed non erat porta, gravida libero ac, commodo erat. Etiam semper eu nunc at venenatis. In nec ligula velit. Donec viverra interdum diam, at scelerisque risus vehicula quis. Sed a ultricies urna. Nulla mollis sem ut mollis lobortis",
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Text(
                  "In euismod dui in magna viverra aliquet. Nunc feugiat ligula non ipsum viverra varius. Donec scelerisque aliquam libero, sit amet ultrices mi condimentum at. Maecenas at feugiat nibh. Phasellus posuere iaculis dictum. Morbi accumsan augue blandit ex cursus commodo. Mauris elementum massa sed risus rhoncus egestas. Pellentesque iaculis facilisis purus, commodo suscipit dui. Nulla facilisi. Sed non erat porta, gravida libero ac, commodo erat. Etiam semper eu nunc at venenatis. In nec ligula velit. Donec viverra interdum diam, at scelerisque risus vehicula quis. Sed a ultricies urna. Nulla mollis sem ut mollis lobortis",
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
