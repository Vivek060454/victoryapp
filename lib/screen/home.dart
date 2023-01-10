import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:victoryupi/screen/pament.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../otp.dart';
import '../widget/login.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex=0;
  final _formKey =GlobalKey<FormState>();
  final  phoneEController = TextEditingController();
  final otpController = TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;
  int _counter = 1;
int selected=2;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _decrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var s=selected*_counter;
    return Scaffold(
      appBar: AppBar(

        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: () {  }, icon: Icon(Icons.menu,color: Colors.black,),
          
        ),
        actions: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              width: 80,
              child: ElevatedButton(onPressed: (){
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>AlertDialog(

                      content: Center(
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
                                              phoneNumber:'+91 '+phoneEController.text,
                                              verificationCompleted: (_) {  },
                                              verificationFailed: (e) {
                                                Fluttertoast.showToast(msg: "Verification Failed ${e.toString()}");
                                                print('Something Went Wrong');
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
                    )
                );
              }, child: Text('Login')),
            ),
          )    ,

        ],

      ),
      drawer: Drawer(),
      body:  SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Container(
                        width: 210,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40)


                        ),
                        child: YoutubePlayer(
                          controller: YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId('https://youtu.be/b5fVm_poOkI').toString(),
                              flags: YoutubePlayerFlags(autoPlay: false)
                          ),

                        //  showVideoProgressIndicator: false,
                          progressIndicatorColor: Colors.blueAccent,

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: SizedBox(
                        width: 210,
                        height: 110,
                        child: Container(
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId('https://youtu.be/B2CfdXyf03E').toString(),
                                flags: YoutubePlayerFlags(autoPlay: false)
                            ),

                            showVideoProgressIndicator: false,
                            progressIndicatorColor: Colors.blueAccent,

                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Container(

                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3.6),
                   2: FlexColumnWidth(1.9),
                    //  2: FlexColumnWidth(4),
                  },
                   children: [
                    TableRow(
                        children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Icon(Icons.diamond_outlined,color: Colors.blue,),
                         ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Free Fire Max Diamonds',style:TextStyle(fontWeight: FontWeight.bold,color:Colors.blue),),
                          ),

                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Table(

                                columnWidths: {
                                  0: FlexColumnWidth(4),
                                  1: FlexColumnWidth(2),

                                  //  2: FlexColumnWidth(4),
                                },
                                children: [
                                  TableRow(
                                      children: [

                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text('Purchase',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                              ],
                                            ),SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Text('History',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.arrow_right),

                                      ]
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ]
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Center(child: Text('Top Up Free Fire Diamonds upto 20% OFF',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),
              Stack(
                children:[
                  CarouselSlider(items: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                         height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)


                          ),
                          child: Image.asset('assets/WhatsApp Image 2023-01-07 at 11.14.40 AM.jpeg',height: 100,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),

                      child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)


                          ),
                          child: Image.asset('assets/WhatsApp Image 2023-01-07 at 11.14.40 AM (1).jpeg',height: 100)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                         height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)


                          ),
                          child: Image.asset('assets/WhatsApp Image 2023-01-07 at 11.14.40 AM.jpeg',height: 100)),
                    )
                  ], options: CarouselOptions(
                    // enlargeCenterPage: true,
                    //  viewportFraction: 0.9,

                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                     height: 100





                  )),
                  Positioned(
                      bottom: 19,
                      left: 100,
                      child:   SizedBox(

                        child: AnimatedSmoothIndicator(
effect: SlideEffect(
    spacing:  8.0,
   // radius:  4.0,
    dotWidth:  6.0,
    dotHeight:  6.0,
    paintStyle:  PaintingStyle.stroke,
    strokeWidth:  1.5,
    dotColor:  Colors.white,
    activeDotColor:  Colors.white

),
                    activeIndex:activeIndex,
                    count:3,



                  ),
                      ))
                ]
              ),
              Divider(
                thickness: 1,
                color: Colors.blue,
              ),
              Table(

                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(2),

                  //  2: FlexColumnWidth(4),
                },
                children:  [

                  TableRow(
                      children: [


                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('M.R.P',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                            ),

                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Victory Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                                )),


                      ]
                  ),

                  TableRow(
                      children: [


                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('₹ 85',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,decoration: TextDecoration.lineThrough,),),
                        ),

                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('₹ ${selected}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.green),),
                            )),


                      ]
                  ),

                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.blue,
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text('No Bonus',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.red),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 185,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),

                             color: Colors.blue
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:40,
                                      ),
                                      Text("111 Diamonds",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),),
                                      Icon(Icons.diamond,color: Colors.lightBlue,size: 10,)
                                    ],
                                  ),
                                  Text('₹ 75',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text('You get + ₹5 Bonus',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.green),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 185,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:40,
                                      ),
                                      Text("280 Diamonds",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),),
                                      Icon(Icons.diamond,color: Colors.lightBlue,size: 10,)
                                    ],
                                  ),
                                  Text('₹ 199',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text('You get + ₹8 Bonus',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.green),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 185,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:40,
                                      ),
                                      Text("580 Diamonds",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),),
                                      Icon(Icons.diamond,color: Colors.lightBlue,size: 10,)
                                    ],
                                  ),
                                  Text('₹ 375',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text('You get + ₹15 Bonus',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.green),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 185,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:40,
                                      ),
                                      Text("1190 Diamonds",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),),
                                      Icon(Icons.diamond,color: Colors.lightBlue,size: 10,)
                                    ],
                                  ),
                                  Text('₹ 760',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text('You get + ₹25 Bonus',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.green),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 185,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:40,
                                      ),
                                      Text("3050 Diamonds",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),),
                                      Icon(Icons.diamond,color: Colors.lightBlue,size: 10,)
                                    ],
                                  ),
                                  Text('₹ 1850',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.blue),)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Text('Code Quantity',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.grey)),
              SizedBox(
                height: 10,
              ),

              Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),

                border: Border.all(color: Colors.green),

                ),
                child: Row(
                  children: [
                    // SizedBox(
                    //   width: 110,
                    // ),
                    IconButton(onPressed: (){
                      setState(() {
                        _counter--;
                      });

                    }, icon: Icon(Icons.horizontal_rule,size: 16,color: Colors.green)),
                    Text(' ${_counter} ',style: TextStyle(color: Colors.green)),
                    IconButton(onPressed: (){
                      setState(() {
                        _counter++;
                      });

                    }, icon: Icon(Icons.add,size: 16,color: Colors.green)),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Total Amount ₹ ${s}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.grey)),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(

                  style: ButtonStyle(

                    backgroundColor: MaterialStateProperty.all( Colors.green )
                  ),
                  onPressed: (){
                    if(auth==null){
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>AlertDialog(
                            content: Center(
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
                                                    phoneNumber:'+91 '+phoneEController.text,
                                                    verificationCompleted: (_) {  },
                                                    verificationFailed: (e) {
                                                      Fluttertoast.showToast(msg: "Verification Failed ${e.toString()}");
                                                      print('Something Went Wrong');
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
                          )
                      );

                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment(s.toString())));
                    }

                  }, child: Text('Buy Now!',style: TextStyle(fontWeight: FontWeight.bold,),))
            ],
          ),
        ),
      ),


    );
  }
}
