import 'package:blogapptwo/pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import '../NetworkHandler.dart';
import 'package:http/http.dart';
import 'dart:convert';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool vis = true;
  //globalkey is used to trigger the validation, here generic is FormState
  final _globalkey = GlobalKey<FormState>();
  //Instance of object NetworkHandler class
  NetworkHandler networkHandler = NetworkHandler();

  //TextEditingController _usernameController = TextEditingController();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign In with Email",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // usernameTextField(),
                emailTextField(),
                SizedBox(height: 15),
                passwordTextField(),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: Text(
                          "New User?",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    setState(() {
                      circular = true;
                    });
                    Map<String, String> data = {
                      "email": _emailController.text,
                      "password": _passwordController.text
                    };

                    final credential = base64.encode(utf8.encode(
                        "${_emailController.text}:${_passwordController.text}"));
                    final header = {"Authorization": "Basic ${credential}"};
                    var response =
                        await networkHandler.post("login", header: header);
                    //decoding json data for token
                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output['token']);
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                    } else {
                      // Map output =json.decode(response.body);
                      String output = json.decode(response.body);

                      setState(() {
                        validate = false;
                        //  errorText=output.toString();
                        errorText = output;
                        circular = false;
                      });
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff00A86B),
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator()
                          : Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                // Divider(height: 50, thickness: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget usernameTextField() {
  //   return customTextFormWIdgit(
  //     title: "Username",
  //     controller: _usernameController,
  //     validate: validate,
  //     errorText: errorText,
  //   );
  // }

  Widget emailTextField() {
    return Column(
      children: [
        Text("Email"),
        TextFormField(
          controller: _emailController,
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
    );
  }

  Widget passwordTextField() {
    return Column(
      children: [
        Text("Password"),
        TextFormField(
          controller: _passwordController,
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
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
    );
  }
}

class customTextFormWIdgit extends StatelessWidget {
  const customTextFormWIdgit(
      {Key key,
      @required this.controller,
      @required this.validate,
      @required this.errorText,
      @required this.title})
      : super(key: key);

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
