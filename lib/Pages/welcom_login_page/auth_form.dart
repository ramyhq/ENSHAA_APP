// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../custom_widgets/buttons.dart';
import '../../data_layer/Cashing_data.dart';
import 'auth_screen.dart';
import 'auth_services/auth.dart';

class AuthForm extends StatefulWidget {
  final AuthType authType;
  const AuthForm({Key? key, required this.authType}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  String _email = '', _passowrd = '', _userRole = '';
  AuthBase authBase = AuthBase();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5),
            TextFormField(
              onChanged: (value) => _email = value,
              validator: (value) =>
                  value!.isEmpty ? 'Enter a valid email' : null,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Enter your email',
                hintText: 'ex: test@gmail.com',
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              onChanged: (value) => _passowrd = value,
              validator: (value) => value!.length < 6
                  ? 'Your password must be larger than 6 characters'
                  : null,
              decoration: InputDecoration(
                labelText: 'Enter your password',
                icon: Icon(Icons.lock_outlined),
              ),
              obscureText: true,
            ),
            SizedBox(height: 5),
            widget.authType == AuthType.register
                ? DropdownButtonFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Individual or Company',
                      hintText: 'Individual or Company',
                    ),
                    value: _userRole.isNotEmpty ? _userRole : null,
                    items: <String>['Individual', 'Company']
                        .map<DropdownMenuItem<String>>((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (val) {
                      _userRole = val.toString();
                    })
                : Container(),
            SizedBox(height: 15),
            Button1(
                text: widget.authType == AuthType.login ? 'Login' : 'Register',
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    if (widget.authType == AuthType.login) {
                      var user = await authBase.loginWithEmailAndPassword(
                          _email.trim(), _passowrd.trim());
                      print('this is from Button1 use is:${user!.role.toString()}');
                      if(user.role == 'Individual'){
                        await Cashing().setMyData('user_role', user.role);
                        Navigator.of(context).pushReplacementNamed('UserHomePage');
                      }else if (user.role == 'Company'){
                        await Cashing().setMyData('user_role', user.role);
                        Navigator.of(context).pushReplacementNamed('CompanyHomePage');
                      }
                    } else {
                      var user = await authBase.registerWithEmailAndPassword(
                          _email.trim(), _passowrd.trim(), _userRole.trim());
                      if(user != null) {
                        Navigator.of(context).pushReplacementNamed('login');
                      }

                    }
                  }
                },
                textColor: Colors.white,
                bgColor: Color(0xFFC7A176)),
            SizedBox(height: 10),
            // create an account? & have an account? button
            TextButton(
              onPressed: () {
                if (widget.authType == AuthType.login) {
                  Navigator.of(context).pushReplacementNamed('register');
                } else {
                  Navigator.of(context).pushReplacementNamed('login');
                }
              },
              child: Text(
                widget.authType == AuthType.login
                    ? 'Create an account?'
                    : 'I have an account',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('GuestWelcomeHome');
              },
              child: Text('need help?',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
