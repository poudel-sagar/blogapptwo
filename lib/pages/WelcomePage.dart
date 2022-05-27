import 'package:flutter/material.dart';


import 'SignUpPage.dart';
import 'SinInPage.dart';

class WelcomePage extends StatefulWidget {
  //const WelcomePage({ Key? key }) : super(key: key);
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}
//extending class with TickerProviderStateMixin to implement animation 
class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController _controller1; 
  Animation<Offset> animation1; 
  //offset is 2d point x,y point of screen.
  AnimationController _controller2;
  Animation<Offset> animation2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //animation 1
    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
  //Tween helps in defining the beginning and ending of the animation
    animation1 = Tween<Offset>(
      //Tween defines beginning and ending of animation
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller1, curve: Curves.easeOut));
    //animation 2
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.bounceOut));
    _controller1.forward();
    _controller2.forward();
  }
//dispose is done in animation in order to stop 
//consuming other resources by animation and to reduce mobile being hang.
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.green[200]],
              begin: FractionalOffset(0.0, 1.0),
              end: FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.repeated),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            children: [
              //SlideTransition widgit implement animation
              SlideTransition(
                position: animation1,
                child: Text(
                  "Moru App",
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              SlideTransition(
                position: animation1,
                child: Text(
                  "अब डिजिटल जीवन शुरु",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                      letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              boxContainer("assets/google.png", "Sign up with Google", null),
              SizedBox(
                height: 20,
              ),
              boxContainer(
                  "assets/facebook1.png", "Sign up with Facebook", null),
              SizedBox(
                height: 20,
              ),
              boxContainer(
                  "assets/email2.png", "Sign up with Email", onEmailClick),
              SizedBox(
                height: 20,
              ),
              //SlideTransition widget is used for animation
              SlideTransition(
                position: animation2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ));
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  onEmailClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }
//custom widget for box to show facebook, google and email part,
// path parameter is for image path, 
//text for text to be printed on card.
  Widget boxContainer(String path, String text, onClick) {
    return SlideTransition(
      position: animation2,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(children: [
                Image.asset(
                  path,
                  height: 25,
                  width: 25,
                ),
                SizedBox(width: 20),
                Text(
                  text,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}