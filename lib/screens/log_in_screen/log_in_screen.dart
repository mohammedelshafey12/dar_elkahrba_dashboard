import 'package:dar_elkahrba/widget/default_input.dart';
import 'package:dar_elkahrba/widget/label_of_text_form_field.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool passwordIsHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('log_in_screen/icon_left.png',),
              SizedBox(height: 20.0,),
              Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 42.0,
                ),
              ),
              SizedBox(height: 40.0,),
              LabelOfTextFormFiled(label: 'USERNAME',),
              SizedBox(height: 20.0,),
              DefaultInput(
                controller: usernameController,
                type: TextInputType.text,
                validator: (value){
                  if (value!.isEmpty){
                    return 'username must be not null';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0,),
              LabelOfTextFormFiled(label: 'PASSWORD',),
              SizedBox(height: 20.0,),
              DefaultInput(
                controller: passwordController,
                obscureText: passwordIsHidden,
                type: TextInputType.visiblePassword,
                validator: (value){
                  if (value!.isEmpty){
                    return 'password must be not null';
                  }
                  return null;
                },
                suffixIcon: passwordIsHidden?Icons.visibility : Icons.visibility_off,
                onTapSuffixIcon: (){
                  setState(() {
                    passwordIsHidden = !passwordIsHidden;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              Container(
                width: double.infinity,
                height: 50.0,
                child: MaterialButton(
                  onPressed: (){
                    if (formKey.currentState!.validate()){

                    }
                  },
                  height: 50.0,
                  child: Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 20,
                    letterSpacing: 0.5,),),
                  focusColor: Colors.green,
                  elevation: 0.0,
                  focusElevation: 0.0,
                  hoverElevation: 0.0,
                  highlightElevation: 0.0,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
