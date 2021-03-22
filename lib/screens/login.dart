
import 'package:appforu/screens/register.dart';
import 'package:appforu/utility/dialog.dart';
import 'package:appforu/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
  double screen;
  bool _securetext = true;
  String email, password;


  Widget buidlLogo() => Container(
        width: screen * 0.53,
        child: Mystyle(). Logo(),
      );

  Widget typeEmail() => Container(
        width: screen * 0.85,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => email = value.trim(),
          decoration: InputDecoration(
            labelText: 'Email',
            icon: Icon(
              Icons.mail_outline_rounded,
              color: Mystyle().darkColor,
              size: 25.0,
            ),
            labelStyle: TextStyle(
              color: Mystyle().darkColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            fillColor: Mystyle().darkColor,
          ),
          maxLength: 100,
        ),
      );

  Widget typePassword() => Container(
        width: screen * 0.85,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Mystyle().darkColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            icon: Icon(
              Icons.vpn_key_outlined,
              color: Mystyle().darkColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _securetext = !_securetext;
                });
              },
            ),
          ),
          obscureText: _securetext,
        ),
      );

  Widget loginButton() => Container(
         width: 300.0,
         height: 60.0,
        child: RaisedButton(
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.white,
            ),
          ),
          color: Mystyle().darkColor,
          onPressed: () {
            if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
              normalDialog(context, 'Please Type Information');
            } else {
              checkAuthen();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
      );



  Widget registerButton() =>
      Container(
        width: 300.0,
        height: 60.0,
        child: RaisedButton(
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          color: Mystyle().darkColor,
          onPressed: () {
            Navigator.pop(context);
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => Register());
            Navigator.push(context, route);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Mystyle().darkColor,
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buidlLogo(),
              SizedBox(
                height: 65.0,
              ),
              typeEmail(),
              Mystyle().showBox(),
              typePassword(),
              SizedBox(
                height: 60.0,
              ),
              loginButton(),
              Mystyle().showBox(),

              Mystyle().showBox(),
              registerButton(),
              Mystyle().showBox(),

              Mystyle().showBox(),

            ],
          ),
        ),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false))
          .catchError((value) => normalDialog(context, value.message));
    });
  }
}
