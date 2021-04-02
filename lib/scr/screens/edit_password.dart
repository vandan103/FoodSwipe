import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodswipe/scr/helpers/screen_navigation.dart';
import 'package:foodswipe/scr/helpers/style.dart';
import 'package:foodswipe/scr/providers/user.dart';
import 'package:foodswipe/scr/screens/home.dart';
import 'package:foodswipe/scr/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  bool abc = false;
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
       appBar: AppBar(
         title: Text("Edit Password"),
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
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(Icons.lock)
                    ),
                    validator: (String value){
                      if(value.isEmpty )
                      {
                        return 'Please a Enter Password';
                      }
                      else if( value.length<6)
                      {
                        return 'enter at least 6 digit';
                      }

                      return null;
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: cpasswordController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: " Confirm Password",
                        icon: Icon(Icons.lock)
                    ),
                    validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please re-enter password';
                      }

                      if(passwordController.text!=cpasswordController.text){
                        return "Password does not match";
                      }
                      return null;
                    },

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()async{
                  userProvider.changePassword(cpasswordController.text);
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
                        CustomText(text: "Update Password", color: white, size: 22,)
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
