import 'package:flutter/material.dart';
import 'package:flutter_todo_apps/model/model_class.dart';
import 'package:flutter_todo_apps/repository/database_connection.dart';
import 'package:flutter_todo_apps/screens/login_screen.dart';
import 'package:flutter_todo_apps/widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistationScreen extends StatefulWidget {
  const RegistationScreen({Key? key}) : super(key: key);

  @override
  _RegistationScreenState createState() => _RegistationScreenState();
}

class _RegistationScreenState extends State<RegistationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  void checkValidation() {
    if (_formkey.currentState!.validate()) {
      var name = nameController.text.toString();
      var phone = phoneController.text.toString();
      var email = emailController.text.toString();
      var password = passController.text.toString();
      var id = 0;
      if (id == 0) {
        SQLHelper.insertDataUser(name, phone, email, password).then((value) => {
              if (value != -1)
                {
                  print("User data inserted Successfully"),
                  toastMessage('Login Successful')
                }
              else
                {print("Failed user data insert")}
            });
      } else
        toastMessage('Something Wrong');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    }
  }

  void toastMessage(var toastText) {
    Fluttertoast.showToast(
        msg: toastText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            checkValidation();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 30,
                    //color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Create a new account',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: nameController,
                  label: const Text('NAME'),
                  hintText: 'Enter your name',
                  prefixIcon: const Icon(Icons.person),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: phoneController,
                  label: const Text('PHONE'),
                  hintText: 'Enter your number',
                  prefixIcon: const Icon(Icons.phone),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  label: const Text('EMAIL'),
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.mail),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: passController,
                  label: const Text('PASSWORD'),
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.password),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return value.length <= 6
                        ? 'Password must be six characters'
                        : null;
                  },
                ),
                const SizedBox(height: 10),
                ModelClass.submitButton(
                    const Text(
                      'CREATE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ), () {
                  checkValidation();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}