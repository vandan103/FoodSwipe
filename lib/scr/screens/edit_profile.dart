import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodswipe/scr/helpers/screen_navigation.dart';
import 'package:foodswipe/scr/helpers/style.dart';
import 'package:foodswipe/scr/providers/user.dart';
import 'package:foodswipe/scr/screens/home.dart';
import 'package:foodswipe/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool abc = false;
  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var addressnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Form(
        autovalidate: abc,
        key: _formKey,
          child: ListView(
            children: <Widget>[
            SizedBox(
            height: 10,
          ),
              Padding(
                padding:  const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(15)
                  ),
                    child: TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                    ),
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: grey),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: addressnameController,
                    keyboardType: TextInputType.text,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      border: InputBorder.none,
                      hintText: 'Address',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: ()async{
                    userProvider.editAddress(addressnameController.text);
                    userProvider.editName(usernameController.text);
                    changeScreen(context, Home());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: red,
                        border: Border.all(color: grey),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomText(text: "Update Profile", color: white, size: 22,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),

          ],
        ),
        ),
    );
  }



}
