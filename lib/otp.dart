import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Home.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final _formKey =GlobalKey<FormState>();
  final TextEditingController otpController = new TextEditingController();

  final LocalStorage stor1 = new LocalStorage('localstorage_app');


  void register()  async{



    if(_formKey.currentState!.validate()){

     Fluttertoast.showToast(msg: "Account Created:)");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Home()), (route) => false);



    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration:  BoxDecoration(
          image: DecorationImage(

            image: AssetImage("assets/login_register_background_option.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(

            child: Padding(
              padding: const EdgeInsets.only(top: 90,left: 30,right: 30,bottom: 30),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text('Detail Verification',style: TextStyle(fontWeight: FontWeight.w500),)),
                  const SizedBox(
                    height: 20,
                  ),

                  Align(
                      alignment: Alignment.topLeft,
                      child:   Row(
                        children: [
                          Text('Enter six digit OTP sent on ',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,),),
                          Text( stor1.getItem('name').toString(),maxLines:1,style:TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        ],
                      ),),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(

                    child: SingleChildScrollView(
                      child: Container(


                        child: Form(
                          key: _formKey,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [



                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PinCodeTextField(appContext: context, length: 6,
                                  validator: (value){
                                    if(value==null||value.isEmpty)
                                    {
                                      return "Enter your otp";
                                    }
                                    if(value.length<6||value.isEmpty)
                                    {
                                      return "Enter your valid otp";
                                    }
                                    return null;
                                  },
                                  //enableActiveFill: true,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.number,
                                  textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
                                  pinTheme: PinTheme(
                                    fieldWidth: 30,
                                    fieldHeight: 40,

                                    activeColor:Colors.black,
                                    selectedColor: Colors.black,
                                  )
                                  ,
                                  onChanged: (valuee) {
                                  print(valuee);

                                },
                                ),
                              ),

                              InkWell(
                                onTap: (){

                                  register();
                                  //
                                  //
                                  // Fluttertoast.showToast(msg: "Agree Terms and Condition");

                                },
                                child: Container(
                                  height: 36,
                                  width: 400,
                                  decoration: BoxDecoration(

                                      gradient: LinearGradient(colors: [Color.fromRGBO(250,3,120,1), Color.fromRGBO(129,12,74,1)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0)
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('VERIFY',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colors.white),)),
                                  ),
                                ),
                              ),


                              SizedBox(
                                height: 900,
                              )
                              //Checkbox
                            ],
                          ),
                        ),
                      ),
                    ),
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
