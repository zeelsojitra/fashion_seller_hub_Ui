import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../Common_screen/Comman_Container.dart';
import '../Common_screen/Comman_TeextFiled.dart';
import '../Common_screen/Comman_text.dart';
import '../email authantication/EmailAuthService.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({Key? key}) : super(key: key);

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> with SingleTickerProviderStateMixin {
  final Email_controler = TextEditingController();
  final Usernamecontroler = TextEditingController();
  final Password_controler = TextEditingController();
  int selected = 0;
  List name = [
    'Sign Up',
    'Sign In',
  ];
  TabController? tabController;
  final gloablekey = GlobalKey<FormState>();
  List tabItem = [
    "Sign Up",
    "Sign In",
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Form(
        key: gloablekey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 17.sp,
            ),
            Comman_TexxtFiled(
              controller: Usernamecontroler,
              hinttext: "Enter Name",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Name";
                }
              },
              onChanged: (value) {
                setState(() {
                  gloablekey.currentState!.validate();
                });
              },
              sufficicon: Usernamecontroler.text.length > 2
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.black,
                    )
                  : SizedBox(),
              prefixicon: Icon(
                Icons.person_outlined,
                size: 20.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Comman_TexxtFiled(
              controller: Email_controler,
              hinttext: "Enter Email",
              validator: (value) {
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!);

                if (emailValid) {
                  return null;
                } else {
                  return "Please enter valid Email Id";
                }
              },
              onChanged: (value) {
                gloablekey.currentState!.validate();
              },
              sufficicon: Email_controler.text.length == 10
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.black,
                    )
                  : SizedBox(),
              prefixicon: Icon(
                Icons.email,
                size: 20.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Comman_TexxtFiled(
              controller: Password_controler,
              obscureText: true,
              hinttext: "Enter password",
              validator: (value) {
                final bool passwordValid = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    .hasMatch(value!);

                if (value.isEmpty) {
                  return "Enter Password";
                } else if (passwordValid != true) {
                  return "please enter valid password";
                }
              },
              onChanged: (value) {},
              prefixicon: Icon(
                Icons.lock,
                size: 20.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Center(
              child: Comman_Container(
                ontap: () {
                  print("hello");
                  if (gloablekey.currentState!.validate()) {
                    EmailAuthService.SignupUser(
                            email: Email_controler.text,
                            password: Password_controler.text)
                        .then((value) async {
                      if (value != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Successfully SignUp Plz Login App"),
                          ),
                        );

                        FirebaseFirestore.instance
                            .collection("Seller")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                          "profile_image": "",
                          "profile_name": Usernamecontroler.text,
                          "profile_email": Email_controler.text,
                        });
                        Usernamecontroler.clear();
                        Email_controler.clear();
                        Password_controler.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Email is Alerdy Use by Anthor Account"),
                          ),
                        );
                      }
                    });
                  }
                },
                height: 35.sp,
                width: 140.sp,
                color: Color(0xff95D5B2),
                child: Center(
                  child: Comman_Text(
                    text: "Sign Up",
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
