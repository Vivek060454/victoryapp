
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localstorage/localstorage.dart';

import 'otp.dart';



class Regis extends StatefulWidget {
  const Regis({Key? key}) : super(key: key);
  @override
  State<Regis> createState() => _RegisState();
}
class _RegisState extends State<Regis> {

  final LocalStorage stor1 = new LocalStorage('localstorage_app');
  bool value=false;
  final _formKey =GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  bool isEmail(String input) => EmailValidator.validate(input);

  bool isPhone(String input) => RegExp(
      r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'
  ).hasMatch(input);
  final TextEditingController phoneEController = new TextEditingController();
  final TextEditingController passwordEController = new TextEditingController();
  final TextEditingController checkController = new TextEditingController();
  final TextEditingController cpasswordEController = new TextEditingController();
@override
 bool passwordVisible=false;
  bool passwordVisible1=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
    passwordVisible1=true;
  }
  void register(String name )  async{

    if(_formKey.currentState!.validate()){
      if(value==true) {
        stor1.setItem("name",phoneEController.text);
        //Fluttertoast.showToast(msg: "Account Created:)");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const OTP()), (route) => false);

      }
      else{
        Fluttertoast.showToast(msg: "Agree Terms and Condition");
      }

    }
  }




  @override
  Widget build(BuildContext context) {

    final emailEFeild= TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        nameController.text=value!;
      },
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
          // prefixIcon: const Icon(Icons.email),
         contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
        alignLabelWithHint: true,
        labelText: "Name",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black
          ),

          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10)
          // )

      ),
      validator: (value){
        if(value==null||value.isEmpty)
        {
          return "Enter your name";
        }
        return null;
      },
    );
    final phoneEFeild= TextFormField(
      autofocus: false,
      controller: phoneEController,
      keyboardType: TextInputType.text,
      onSaved: (value){
        phoneEController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        //  prefixIcon: const Icon(Icons.call),

          contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
          labelText:"Email/ Contact Number",
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black,
          ),
        alignLabelWithHint: true,
          // hintText:  "Email/ Contact Number",
          // hintStyle: TextStyle(
          //     fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black
          // )
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10)
          // )
      ),
      validator: (value){
        if (!isEmail(value!) && !isPhone(value)) {
          return 'Please enter a valid email or phone number.';
        }
        return null;
      },

    );
    final passwordEFeild= TextFormField(
      autofocus: false,
     obscureText: passwordVisible,
      controller: passwordEController,
      onSaved: (value){
        passwordEController.text=value!;
      },

      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(passwordVisible
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,color: Colors.black,size: 20,),
          onPressed: () {
            setState(
                  () {
                passwordVisible = !passwordVisible;
              },
            );
          },
        ),
        //  prefixIcon: const Icon(Icons.vpn_key),
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
          labelText:  "Password",
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black
          )
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10)
          // )
      ),
      validator: (value){
        if(value==null||value.isEmpty)
        {
          return "Enter your password";
        }
        return null;
      },

    );
    final cpasswordEFeild= TextFormField(
      autofocus: false,
      obscureText: passwordVisible1,
      controller: cpasswordEController,
      onSaved: (value){
        cpasswordEController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
         // prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon: Icon(passwordVisible1
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,color: Colors.black,size: 20,),
            onPressed: () {
              setState(
                    () {
                  passwordVisible1 = !passwordVisible1;
                },
              );
            },
          ),
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
          labelText:   "Re-enter Password",
          labelStyle: TextStyle(
              fontWeight: FontWeight.w400,fontSize: 13,color: Colors.black
          )
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10)
          // )
      ),
      validator: (value){
        if(value==null||value.isEmpty)
        {
          return "Enter your password";
        }
        if(cpasswordEController.text!= passwordEController.text){
          return ("password not match");
        }
        return null;
      },
    );
    // final signup =Material(
    //   elevation: 5,
    //
    //   borderRadius: BorderRadius.circular(0),
    //   child: MaterialButton(
    //
    //     padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
    //     minWidth: MediaQuery.of(context).size.width,
    //     onPressed: (){
    //       if(value==true) {
    //         register(nameController.text, passwordEController.text);
    //       }
    //       else{
    //        // Fluttertoast.showToast(msg: "Agree Terms and Condition");
    //       }
    //     },
    //     child: const Text('Sign Up',textAlign: TextAlign.center,style: const TextStyle(fontSize: 20),),
    //   ),
    // );

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
          child: Container(


            child: Padding(
              padding: const EdgeInsets.only(top: 90,left: 30,right: 30,bottom: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text('Create Account',style: TextStyle(fontWeight: FontWeight.w500),)),
                    const SizedBox(
                      height: 20,
                    ),
                    Table(
                      columnWidths: {
                        0:FlexColumnWidth(2),
                        1:FlexColumnWidth(2)
                      },
                      children: [
                        TableRow(
                          children: [
                            Align(alignment:Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8,
                                  right: 15,left: 8),
                                  child: InkWell(
                                    onTap: (){},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                          offset: Offset(0, 3),
                                            color: Colors.grey, //New
                                            blurRadius: 2.0,
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image.asset('assets/btn_google_dark_normal_ios.png',scale: 1.4),
                                      ),
                                    ),
                                  ),
                                )),

                            Align(alignment:Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8,
                                      right: 8,left: 15),
                                  child: InkWell(
                                    onTap: (){},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 3),
                                            color: Colors.grey, //New
                                            blurRadius: 2.0,
                                          )
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Image.asset('assets/f_logo_rgb_blue_1024.png',scale: 1.5,),
                                      ),
                                    ),
                                  ),
                                )),
                          ]
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Center(child: Text('or be classical',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black87),)),
                    emailEFeild,
                    const SizedBox(
                     // height: 10,
                    ),
                    phoneEFeild,
                    const SizedBox(
                    //  height: 10,
                    ),
                    passwordEFeild,
                    const SizedBox(
                   //   height: 10,
                    ),
                    cpasswordEFeild,
                    const SizedBox(
                  height: 10,
                    ),
                    // signup,
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Row(
                      children: [
                        Checkbox(

                          activeColor: Color.fromARGB(255,0 , 18, 50),
                          value: value,
                          onChanged: (value) => setState(() {
                            this.value = value!;
                          }),
                        ),
                        Row(
                          children: [
                            Text('I agree with',style:TextStyle(fontSize: 12)),
                            TextButton(
                              onPressed: () {
                                //  Navigator.push(context, MaterialPageRoute(
                                //    builder: (context) =>Terms()));
                              }, child: Text( 'Privacy Policy, Terms & Conditions',style:TextStyle(color: Color.fromRGBO(250,3,120,1),fontSize: 11,),),
                            ),
                          ],
                        )
                      ],
                    ),
                InkWell(
                  onTap: (){

                      register(phoneEController.text);




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
    child: Center(child: Text('SIGN UP',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colors.white),)),
  ),
),
                ),

                    Center(
                      child: Row(
                        children: [
                          Text('            Already have an account?',style:TextStyle(fontSize: 12)),
                          TextButton(
                            onPressed: () {
                              //  Navigator.push(context, MaterialPageRoute(
                              //    builder: (context) =>Terms()));
                            }, child: Text('Sign in',style:TextStyle(color: Color.fromRGBO(250,3,120,1),fontSize: 12,),),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    )
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
