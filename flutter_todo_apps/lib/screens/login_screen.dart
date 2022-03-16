import 'package:flutter/material.dart';
import 'package:flutter_todo_apps/model/model_class.dart';
import 'package:flutter_todo_apps/repository/database_connection.dart';
import 'package:flutter_todo_apps/screens/home_screen.dart';
import 'package:flutter_todo_apps/screens/registation_screen.dart';
import 'package:flutter_todo_apps/widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  List<Map<String, dynamic>> _dataList = [];

  SharedPreferences? sharedPreferences;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  getAllDataUser() async {
    var List = await SQLHelper.getAllDataUser();
    setState(() {
      _dataList = List;
      saveUserData;
    });
  }



  void saveUserData(String userid) async{

    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences?.setString("userId", userid);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  checkLogin(var checkEmail, var checkPassword) async {
    String result = await SQLHelper.checkLogin(checkEmail, checkPassword);
    if (result.isNotEmpty) {
      saveUserData(result);
    } else {
      toastMessage("invalid email & password");
    }
  }

  void toastMessage(var toastText) {
    Fluttertoast.showToast(
        msg: toastText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.red,
        fontSize: 16.0);
  }

  getAllData() async {
    //var List = await SQLHelper.getAllData();
    setState(() {
      //_dataList = List;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getAllData();
  }

  bool _isVisible = false;
  void upDateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 110, color: Colors.black12),
                const SizedBox(height: 15),
                const Text(
                  'Wellcome Back',
                  style: TextStyle(
                    fontSize: 30,
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'sign in to continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  labelText: "EMAIL",
                  prefixIcon: const Icon(Icons.mail),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a Email Address';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please a Valid Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: passController,
                  hintText: "Enter your password",
                  labelText: "PASSWORD",
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: _isVisible ? false : true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      upDateStatus();
                    },
                    icon: Icon(
                        _isVisible ? Icons.visibility : Icons.visibility_off),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return value.length <= 6
                        ? 'Password must be six characters'
                        : null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ModelClass.submitButton(
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  () {
                    checkLogin(emailController.text, passController.text);
                    // getAllData();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistationScreen()),
                        );
                      },
                      child: const Text(
                        'create a new account',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}