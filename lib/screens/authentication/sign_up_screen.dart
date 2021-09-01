import 'package:dar_elkahrba/Models/UserModel.dart';
import 'package:dar_elkahrba/Servises/Auth.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/providers/modelHud.dart';
import 'package:dar_elkahrba/screens/authentication/login_screen.dart';
import 'package:dar_elkahrba/widgets/default_button.dart';
import 'package:dar_elkahrba/widgets/label_of_text_form_field.dart';
import 'package:dar_elkahrba/widgets/default_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passwordIsHidden = true;
  String? email , password ,confirmPasssword,name;
  Auth _auth = Auth();
  Store _store = Store();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: Provider.of<modelHud>(context).isloading,
          child: Container(
            width: width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 42.0,
                                  ),
                                ),
                                SizedBox(
                                  height: width * 0.02,
                                ),
                                Container(
                                  width: width * 0.25,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      LabelOfTextFormFiled(
                                        label: 'NAME',
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      DefaultInput(
                                        onchange: (value){
                                          setState(() {
                                            name = value;
                                          });
                                        },
                                        controller: nameController,
                                        type: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'name must be not null';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      LabelOfTextFormFiled(
                                        label: 'EMAIL',
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      DefaultInput(
                                        onchange: (value){
                                          setState(() {
                                            email = value;
                                          });
                                        },
                                        controller: emailController,
                                        type: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'email must be not null';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      LabelOfTextFormFiled(
                                        label: 'PASSWORD',
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      DefaultInput(
                                        onchange: (value){
                                          setState(() {
                                            password = value;
                                          });
                                        },
                                        controller: passwordController,
                                        obscureText: passwordIsHidden,
                                        type: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'password must be not null';
                                          } else if (passwordController
                                                  .text.length <
                                              8) {
                                            return 'password must > 8 letter';
                                          }
                                          return null;
                                        },
                                        suffixIcon: passwordIsHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        onTapSuffixIcon: () {
                                          setState(() {
                                            passwordIsHidden = !passwordIsHidden;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      LabelOfTextFormFiled(
                                        label: 'CONFIRM PASSWORD',
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      DefaultInput(
                                        onchange: (value){
                                          setState(() {
                                            confirmPasssword = value;
                                          });
                                        },
                                        controller: confirmPasswordController,
                                        obscureText: passwordIsHidden,
                                        type: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'password must be not null';
                                          } else if (passwordController.text !=
                                              confirmPasswordController.text) {
                                            return 'passwords not match';
                                          }
                                          return null;
                                        },
                                        suffixIcon: passwordIsHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        onTapSuffixIcon: () {
                                          setState(() {
                                            passwordIsHidden = !passwordIsHidden;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: width * 0.01,
                                      ),
                                      DefaultButton(
                                        title: 'Sign Up',
                                        onPressed: () async {
                                          if (formKey.currentState!.validate()) {

                                            final modelhud = Provider.of<modelHud>(context,
                                                listen: false);
                                              modelhud.isprogressloding(true);
                                              try {
                                                final authResult = await _auth
                                                    .sign_up_with_email_and_password(
                                                    email!, password!, context);
                                                modelhud.isprogressloding(false);

                                                User? userAuth = await FirebaseAuth
                                                    .instance.currentUser!;
                                                _store.adduser(UserModel(
                                                   name,
                                                  userAuth.uid
                                                    ));
                                              } on PlatformException catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    e.message.toString(),
                                                    style: TextStyle(
                                                        fontFamily: 'custom_font'),
                                                  ),
                                                ));
                                                modelhud.isprogressloding(false);
                                              }

                                              modelhud.isprogressloding(false);
                                            }




                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Image.asset(
                                    'assets/authentication/photo_right.png'),
                                Stack(
                                  children: [
                                    Opacity(
                                      opacity: 0.5,
                                      child: Container(
                                        color: Colors.black,
                                        height: 220,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(
                                          top: 5.0,
                                          bottom: 143.0,
                                          start: 10.0,
                                        ),
                                        child: Text(
                                          'Welcome to Dar Elkahraba .',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('If you have an account'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
