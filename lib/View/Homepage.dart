import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisp/View/constants/buttons.dart';
import 'package:whisp/View/constants/chatlistview.dart';
import 'package:whisp/View/constants/searchbar.dart';

import '../Models/Userinfo.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> names = [];
  List<Userinfo> data = [];

  loadData() {
    List<String> fakeNames = [
      "Aarav",
      "Sarika",
      "Kavya",
      "Aditya",
      "Surya",
      "Neha",
      "Arjun",
      "Pooja",
      "Rohan",
      "Ananya",
    ];

    names.addAll(fakeNames);
    setState(() {
    });
    List<Userinfo> chatMessages = List.generate(
      names.length,
          (index) => Userinfo(
        whispid: 3690004 + 1,
        name: names[index],
        image: "assets/profile_image.jpg",
        time: "12:30 PM",
      ),
    );

    data = chatMessages;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "𝕎𝕙𝕚𝕤𝕡",
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DarkModeToggle(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              NeumorphicSearchBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return NeumorphicTile(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage("assets/Icons/user_icon.png"),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index].name,style: TextStyle(fontSize: 18,fontFamily: 'Whisp'),),
                                SizedBox(height: 4),
                                Text(
                                  "ID: ${data[index].whispid}",
                                  style: TextStyle(fontSize: 12,fontFamily: 'Whisp'),
                                ),
                              ],
                            ),
                            trailing: Text(data[index].time),
                            // Customize the ListTile content as needed
                          ),
                      );
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
