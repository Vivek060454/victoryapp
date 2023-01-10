import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../otp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey =GlobalKey<FormState>();
  final  phoneEController = TextEditingController();
  final otpController = TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
title: Text('hi'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    TextFormField(
                      autofocus: false,
                      controller: phoneEController,
                      keyboardType: TextInputType.phone,
                      onSaved: (value){
                        phoneEController.text=value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.call),
                          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      validator: (value){
                        if(value==null||value.isEmpty)
                        {
                          return "Enter your phone number";
                        }
                        if(value.length>10||value.length<10)
                        {
                          return "Enter your valid phone number";
                        }

                        return null;
                      },

                    ),
                    const SizedBox(
                      height: 30,
                    ),


                    Material(
                      elevation: 5,

                      borderRadius: BorderRadius.circular(40),
                      child: MaterialButton(

                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: (){

                          auth.verifyPhoneNumber(
                              phoneNumber: phoneEController.text,
                              verificationCompleted: (_) {  },
                              verificationFailed: (e) {
                                Fluttertoast.showToast(msg: "Verification Failed ${e.toString()}");
                                print('errrrprrr${e}');
                              },
                              codeSent: (String verificationId, int? Token) {


                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Otp( verificationId)));
                              },
                              codeAutoRetrievalTimeout: (e) {
                                Fluttertoast.showToast(msg: "Time out ${e.toString()}");
                              }

                          );

                          //   register(emailEController.text, passwordEController.text);


                        },

                        child: const Text('Sign Up',textAlign: TextAlign.center,style: const TextStyle(fontSize: 20),),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //Checkbox
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
