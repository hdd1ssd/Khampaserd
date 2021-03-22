import 'package:appforu/screens/login.dart';
import 'package:appforu/screens/register.dart';
import 'package:appforu/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _folded = true;
  String name, email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameandEmail();
  }

  Future<Null> findNameandEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event.displayName;
          email = event.email;
        });
      });
    });
  }

  final List<String> _Stickerlist = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
    'assets/images/8.jpg',
    'assets/images/9.jpg',
    'assets/list/10.jpg',
    'assets/list/11.jpg',
    'assets/list/12.jpg',
    'assets/list/13.jpg',
    'assets/list/14.jpg',
    'assets/list/15.jpg',
    'assets/list/16.jpg',
    'assets/list/17.jpg',
    'assets/list/18.jpg',
  ];

  Widget showDrawer() {
    return UserAccountsDrawerHeader(
      
      decoration: BoxDecoration(color: Mystyle().darkColor),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.people,
          size: 37.0,
          color: Mystyle().darkColor,
        ),
      ),
      accountName: Text(name == null ? 'Name' : name),
      accountEmail: Text(email == null ? 'email' : email),
    );
  }



  Widget showSetting() => ListTile(
        leading: Icon(Icons.settings_applications_outlined),
        title: Text('Setting'),
        onTap: () {},
      );

  Widget showmyAccout() => ListTile(
        leading: Icon(Icons.account_circle_outlined),
        title: Text('Account'),
        onTap: (){} ,
  );

  Widget showlogOut() => ListTile(
        leading: Icon(Icons.logout),
        title: Text('Log Out'),
        onTap: () async {
          await Firebase.initializeApp().then((value) async {
            await FirebaseAuth.instance.signOut().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false));
          });
        },
      );

  Widget shop() => ListTile(
    leading: Icon(Icons.shopping_bag_outlined),
    title: Text('Shop'),
    onTap: () {},
  );

  Widget shop1() => ListTile(
    leading: Icon(Icons.shopping_cart_outlined),
    title: Text('Cart'),
    onTap: () {},
  );

  Widget showDrawerList() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            showDrawer(),
            shop(),
            shop1(),
            showmyAccout(),
            showSetting(),
            showlogOut(),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Shop"),
        backgroundColor:  Mystyle().darkColor,
        actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
          Navigator.pop(context);
          MaterialPageRoute route =
          MaterialPageRoute(builder: (value) => Login());
        Navigator.push(context, route);})],
      ),
      drawer: showDrawerList(),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(20.0),
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 10.0,
          children: _Stickerlist
              .map((item) => Card(
                    elevation: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(item),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Transform.translate(
                        offset: Offset(70, -60),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 50.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
