import 'package:dar_elkahrba/Models/admin_model.dart';
import 'package:dar_elkahrba/Servises/Auth.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/providers/model_hud.dart';
import 'package:dar_elkahrba/widgets/auth/auth_custom_button.dart';
import 'package:dar_elkahrba/widgets/auth/auth_custom_text_form_field_password.dart';
import 'package:dar_elkahrba/widgets/auth/auth_custom_text_form_field_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController adminNameController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool visibleText = true;
  Auth _auth = Auth();
  Store _store = Store();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
        body: Center(
          child: Container(
            width: width * 0.75,
            height: height * 0.9,
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              child: Form(
                key: formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: height,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                          ),
                          child: Image.asset(
                            Constants.signUpPhoto,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'custom_font_bold',
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Text(
                                  'Please fill below the required data to Sign Up Dashboard',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13.0,
                                    fontFamily: 'custom_font',
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                AuthCustomTextFormFieldText(
                                  title: 'Name',
                                  icon: Icons.person,
                                  controller: adminNameController,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                AuthCustomTextFormFieldText(
                                  title: 'Email',
                                  icon: Icons.email,
                                  controller: adminEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                AuthCustomTextFormFieldPassword(
                                  title: 'Password',
                                  controller: adminPasswordController,
                                  visible: visibleText,
                                  onPressed: () {
                                    setState(() {
                                      visibleText = !visibleText;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                AuthCustomButton(
                                  title: 'Sign Up',
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      final modelHud = Provider.of<ModelHud>(
                                        context,
                                        listen: false,
                                      );
                                      modelHud.isProgressLoading(true);
                                      try {
                                        final authResult = await _auth
                                            .signUpWithEmailAndPassword(
                                          email: adminEmailController.text,
                                          password:
                                              adminPasswordController.text,
                                          context: context,
                                        );
                                        User? userAuth =
                                            FirebaseAuth.instance.currentUser!;
                                        _store.addAdmin(
                                          AdminModel(
                                            adminId: userAuth.uid,
                                            adminName: adminNameController.text,
                                            adminEmail: adminEmailController.text,
                                          ),
                                        );
                                        modelHud.isProgressLoading(false);
                                      } on PlatformException catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              e.message.toString(),
                                            ),
                                          ),
                                        );
                                        modelHud.isProgressLoading(false);
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'If you have an account',
                                    style: TextStyle(
                                      fontFamily: 'custom_font',
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Constants.navigatorPush(
                                      context: context,
                                      screen: LogInScreen(),
                                    );
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'custom_font_bold',
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
