import 'package:flutter/material.dart';
import '../NetworkHandler.dart';
import 'package:http/http.dart';
import 'dart:convert';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}
  
class _SignUpPageState extends State<SignUpPage> {
  bool vis = true;
  //globalkey is used to trigger the validation, here generic is FormState
  final _globalkey = GlobalKey<FormState>();
  //Instance of object NetworkHandler class
  NetworkHandler networkHandler = NetworkHandler();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  String errorText;
  bool validate = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green[200]],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Form(
          key: _globalkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up with email",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              usernameTextField(),
              emailTextField(),
              passwordTextField(),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async 
                 {
                  setState(() {
                    circular = true;
                  }); 
                  //await checkUser();
                 // if (_globalkey.currentState.validate() && validate ) {
                    //sending the data to rest server
                    Map<String, String> data = {
                      "username": _usernameController.text,
                      "email": _emailController.text,
                      "password": _passwordController.text,
                     
                    };
                    print(data);
                    var responseRegister =
                      await networkHandler.post("register", data);
                    print(responseRegister);

                    setState(() {
                      circular = false;
                    });
                  // } 
                  // else {
                  //   setState(() {
                  //     circular = false;
                  //   });
                  // }
                },
                child: circular
                    ? CircularProgressIndicator()
                    : Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff00A86B),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //checkusername to call get API to check the user
   
  // checkUser() async {
  //   if (_usernameController.text.length == 0) {
  //     setState(() {
  //       circular = false;
  //       validate = false;
  //       errorText = "Username Can't be empty";
  //     });
  //   } else {

  //     //getting user if it is already present in our api/database 
      
  //     var response = await networkHandler
  //         .get("/users${_usernameController.text}");
  //     if (response['Status']) {
  //       setState(() {
  //         // circular = false;
  //         validate = false;
  //         errorText = "Username already taken";
  //       });
  //     } else {
  //         validate = true;
        
  //     }
  //   }
  // }

  Widget usernameTextField() {
    return customTextFormWIdgit(
      title: "Username",
      controller: _usernameController, validate: validate, errorText: errorText,);

  }


  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Email"),
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return "Email can't be empty";
              if (!value.contains("@")) return "Email is Invalid";
              return null;
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
 
  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text("Password"),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return "Password can't be empty";
              if (value.length < 8) return "Password lenght must have >=8";
              return null;
            },
            obscureText: vis,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    vis = !vis;
                  });
                },
              ),
              helperText: "Password length should have >=8",
              helperStyle: TextStyle(
                fontSize: 14,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class customTextFormWIdgit extends StatelessWidget {
  const customTextFormWIdgit({
    Key key,
    @required this.controller,
    @required this.validate,
    @required this.errorText,
    @required this.title
  }): super(key: key);

  final TextEditingController controller;
  final bool validate;
  final String errorText;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
      child: Column(
        children: [
          Text(title),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2, 
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}