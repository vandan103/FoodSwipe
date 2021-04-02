import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodswipe/scr/helpers/order.dart';
import 'package:foodswipe/scr/helpers/user.dart';
import 'package:foodswipe/scr/models/cart_item.dart';
import 'package:foodswipe/scr/models/order.dart';
import 'package:foodswipe/scr/models/products.dart';
import 'package:foodswipe/scr/models/user.dart';
import 'package:uuid/uuid.dart';


enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserServices _userServicse = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;



//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;


  List<OrderModel> orders = [];

  final formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cpassword=TextEditingController();
  TextEditingController adress=TextEditingController();


  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }

  Future<bool> signIn()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }


  Future<bool> signUp()async{
    try{
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(email: email.text.trim(), password: cpassword.text.trim()).then((result){
        _firestore.collection('users').document(result.user.uid).setData({
          'name':name.text,
          'email':email.text,
          'uid':result.user.uid,
          'address':adress.text,
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }
  Future changePassword(String newpassword) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    user.updatePassword(newpassword).then((_){
      print("Successfully changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future editAddress(String address)async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _firestore.collection('users').document(user.uid).updateData({
      'address':address,
    }).then((_) =>  print("Successfully changed address") )
        .catchError((onError){
          print("address can't changed " + onError.toString() );
    });

  }
  Future editName(String name)async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _firestore.collection('users').document(user.uid).updateData({
      'name':name,
    }).then((_) => print("Successfully changed name"))
    .catchError((onError)=> print("name can't changed" + onError.toString() ));

  }



  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController(){
    name.text = "";
    password.text = "";
    cpassword.text = "";
    email.text = "";
  }

  Future<void> reloadUserModel()async{
    _userModel = await _userServicse.getUserById(user.uid);
    notifyListeners();
  }


  Future<void> _onStateChanged(FirebaseUser firebaseUser) async{
    if(firebaseUser == null){
      _status = Status.Unauthenticated;
    }else{
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServicse.getUserById(user.uid);
    }
    notifyListeners();
  }

  Future<bool> addToCard({ProductModel product, int quantity}) async{
    print("THE PRODUCT IS: ${product.toString()}");
    print("THE quantity IS: ${quantity.toString()}");

    try{
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;
      Map cartItem ={
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "restaurantId": product.restaurantId,
        "totalRestaurantSale": product.price * quantity,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

        CartItemModel item = CartItemModel.fromMap(cartItem);
        print("CART ITEMS ARE: ${cart.toString()}");
        _userServicse.addToCart(userId: _user.uid, cartItem: item);
      return true;

    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }

  getOrders()async{
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({CartItemModel cartItem})async{
    print("THE PRODUCT IS: ${cartItem.toString()}");

    try{
      _userServicse.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    }catch(e){
      print("THE ERROR ${e.toString()}");
      return false;
    }

  }
}