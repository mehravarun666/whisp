import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          Container(
            color: Colors.grey,
            height: 200,
            width: MediaQuery.of(context).size.width-1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Icons/user_icon.png',
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 8),
                Text(
                  'Whisp Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(user.email!)

              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(width: 8,),
                          Icon(Icons.account_circle_outlined,size: 33,),
                          SizedBox(width: 15),
                          Text(
                            'Your Account',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(width: 8,),
                          Icon(Icons.add_a_photo_outlined,size: 33,),
                          SizedBox(width: 15),
                          Text(
                            'Add image',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(width: 8,),
                          Icon(Icons.settings,size: 33,),
                          SizedBox(width: 15),
                          Text(
                            'Settings',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
      ElevatedButton(
        onPressed: ()=> FirebaseAuth.instance.signOut(),
        child: Container(
          width: 200,
          child: Center(
            child: Row(
              children: [
                Icon(Icons.exit_to_app,color: Colors.white,),
                Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.grey, // Change button color here
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }
}
