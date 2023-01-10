import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Otp extends StatefulWidget {
  final verificationId;
  const Otp (this.verificationId, {Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final _formKey =GlobalKey<FormState>();

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
                      controller: otpController,
                      keyboardType: TextInputType.phone,
                      onSaved: (value){
                        otpController.text=value!;
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
