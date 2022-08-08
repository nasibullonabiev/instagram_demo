import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_demo/Screens/sign_in_screen.dart';
import 'package:instagram_demo/services/utils_service.dart';

import '../Theme/Colors.dart';
import '../services/auth_service.dart';
import '../services/db_service.dart';

class SignUpScreen extends StatefulWidget {
  
  static const String id = 'sign_up_screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _signUp()async{
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();


    if(fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      Utils.fireSnackBar("Please fill all gaps", context);
      return;
    }
    isLoading = true;
    setState(() {});

    AuthService.signUpUser(context, fullName, email, password,confirmPassword).then((user) => _checkNewUser(user));
  }

  void _checkNewUser(User? user) async {
    if(user != null) {
      await DBService.saveUserId(user.uid);
      if(mounted) Navigator.pushReplacementNamed(context, SignInScreen.id);
    } else {
      Utils.fireSnackBar("Please check your entered data, Please try again!", context);
    }

    isLoading = false;
    setState(() {});
  }

  void _catchError() {
    Utils.fireSnackBar("Something error in Service, Please try again later", context);
    isLoading = false;
    setState(() {});
  }

  void _goSignIn() {
    Navigator.pushReplacementNamed(context, SignInScreen.id);
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

              // #fullname
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),

                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: fullNameController,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: "Fullname",
                        border: InputBorder.none
                    ),

                  ),
                ),
              ),

              const SizedBox(height: 15,),


              //#email
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),

                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: "Email",
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

              // #confirmPassword
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade300)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),

                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child:  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    decoration: const InputDecoration(
                        hintText: "Confirm Password",
                        border: InputBorder.none
                    ),

                  ),
                ),
              ),

              const SizedBox(height: 15,),


              const SizedBox(height: 10,),


              // #signUp
              SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: signInButton

                    ),
                    onPressed: _signUp, child: const Text("Sign Up")),
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

              const SizedBox(height: 30,),

              const Divider(),
              const SizedBox(height: 0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Text("Already have an account"),
                  SizedBox(width: 10,),
                  GestureDetector(
                    onTap: _goSignIn,
                      child: Text("Sign In",style: TextStyle(color: Colors.blue),))
                ]
              )


            ],
          ),
        ),
      ),


    );;
  }
}
