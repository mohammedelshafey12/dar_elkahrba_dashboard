import 'package:dar_elkahrba/Servises/Auth.dart';
import 'package:dar_elkahrba/Servises/store.dart';
import 'package:dar_elkahrba/providers/model_hud.dart';
import 'package:dar_elkahrba/screens/auth/sign_up_screen.dart';
import 'package:dar_elkahrba/widgets/auth/auth_custom_button.dart';
import 'package:dar_elkahrba/widgets/auth/auth_custom_text_form_field_password.dart';
import 'package:dar_elkahrba/widgets/auth/auth_custom_text_form_field_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                            Constants.logInPhoto,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sign In',
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
                                  'Please fill below the required data to log in Dashboard',
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
                                  title: 'Email',
                                  icon: Icons.email,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                AuthCustomTextFormFieldPassword(
                                  title: 'Password',
                                  controller: passwordController,
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
                                  title: 'Sign In',
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      final modelHud = Provider.of<ModelHud>(
                                        context,
                                        listen: false,
                                      );
                                      modelHud.isProgressLoading(true);
                                      try {
                                        final authResult = await _auth
                                            .signInWithEmailAndPassword(
                                          email: emailController.text.trim(),
                                          password: passwordController.text.trim(),
                                          context: context,
                                        );

                                        modelHud.isProgressLoading(false);
                                      } on PlatformException catch (e) {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              e.message.toString(),
                                              style: TextStyle(
                                                  fontFamily: 'custom_font'),
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
                                    'If you don\'t have an account',
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
                                      screen: SignUpScreen(),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
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
                    )
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
