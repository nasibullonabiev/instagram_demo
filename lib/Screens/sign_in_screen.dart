import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_demo/Screens/navigator.dart';
import 'package:instagram_demo/Screens/sign_up_screen.dart';


import '../Theme/Colors.dart';
import '../services/auth_service.dart';
import '../services/db_service.dart';
import '../services/utils_service.dart';

class SignInScreen extends StatefulWidget {

  static const String id = 'sign_in_screen';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void _signIn() {
    String email = usernameController.text.trim();
    String password = passwordController.text.trim();

    if(email.isEmpty || password.isEmpty) {
      Utils.fireSnackBar("Please fill all gaps", context);
      return;
    }

    isLoading = true;
    setState(() {});

    AuthService.signInUser(context, email, password).then((user) => _checkUser(user));
    Navigator.pushReplacementNamed(context, NavigatorScreen.id);

  }

  void _checkUser(User? user) async {
    if(user != null) {
      debugPrint(user.toString());
      await DBService.saveUserId(user.uid);
      // if(mounted) Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireSnackBar("Please check your entered data, Please try again!", context);
    }

    isLoading = false;
    setState(() {});
  }

  Future<void> _catchError() async{
    Utils.fireSnackBar("Something error in Service, Please try again later", context);
    isLoading = false;
    setState(() {});
  }

  void _goSignUp() {
    Navigator.pushReplacementNamed(context, SignUpScreen.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height:200,),
              const Center(child: Text("Instagram",style: TextStyle(color: black,fontFamily: "Billabong",fontSize: 60),)),
              const SizedBox(height: 10,),

              // #username
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  border: Border.all(color: Colors.grey.shade300)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),

                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Username",
                      border: InputBorder.none
                    ),

                  ),
                ),
              ),

             const SizedBox(height: 15,),

              // #password
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),

                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child:  TextField(
                    controller: passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: "Password",
                        border: InputBorder.none
                    ),

                  ),
                ),
              ),

              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    //TODO: write code for forgot password
                  },
                      child: const Text("Forgot password?")),

                  const SizedBox(width: 20,)

                ],
              ),

              const SizedBox(height: 10,),


              // #signin
              SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                 backgroundColor: signInButton

               ),
                    onPressed: _signIn, child: const Text("Sign In")),
              ),
              
              const SizedBox(height: 40,),


              // #login with facebook
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.facebook,color: Colors.blue,size: 30,),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      //TODO: write code for login with facebook
                    },
                      child: const Text("Log in with Facebook",style: TextStyle(color: signInButton),)),
                ],
              ),

              const SizedBox(height: 40,),
              
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/line.svg"),
                  const SizedBox(width: 10,),
                  const Text("OR",style: TextStyle(color: Colors.grey),),
                  const SizedBox(width: 10,),
                  SvgPicture.asset("assets/images/line.svg"),
                ],
              ),

              const SizedBox(height: 80,),

              const Divider(),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: _goSignUp,
                    child: Text("Sign Up",style: TextStyle(color: Colors.blue),),
                  )
                ],
              ),

               SizedBox(height: 10,),
               const Text("Instagram by Facebook")


            ],
          ),
        ),
      ),


    );
  }
}
