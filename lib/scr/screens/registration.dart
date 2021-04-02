import 'package:flutter/material.dart';
import 'package:foodswipe/scr/helpers/screen_navigation.dart';
import 'package:foodswipe/scr/helpers/style.dart';
import 'package:foodswipe/scr/providers/user.dart';
import 'package:foodswipe/scr/screens/login.dart';
import 'package:foodswipe/scr/widgets/custom_text.dart';
import 'package:foodswipe/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: userProvider.status == Status.Authenticating? Loading() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/logo.png", width: 100, height: 100,),
              ],
            ),

            SizedBox(
              height: 40,
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
                    controller: userProvider.name,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        icon: Icon(Icons.person)
                    ),
                    validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please Enter Username';
                      }
                      return null;
                    },
                  ),),
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
                    controller: userProvider.email,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        icon: Icon(Icons.email)
                    ),
                    validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please  Enter Email';
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                  ),),
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
                    controller: userProvider.adress,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Address",
                        icon: Icon(Icons.location_on),
                    ),
                    validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please Enter Address';
                      }
                      return null;
                    },
                  ),),
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
                    controller: userProvider.password,
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
                    controller: userProvider.cpassword,
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

                      if(userProvider.password.text!=userProvider.cpassword.text){
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
                  print(" REGISTER BTN CLICKED!!!!");


                  if(!await userProvider.signUp()){
                    _key.currentState.showSnackBar(
                        SnackBar(content: Text("Resgistration failed!"))
                    );
                    return;
                  }
                  userProvider.clearController();
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
                        CustomText(text: "Register", color: white, size: 22,)
                      ],
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                changeScreen(context, LoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomText(text: "Already have account? plz login", size: 20,),
                ],
              ),
            ),




          ],
        ),
      ),
    );
  }
}
