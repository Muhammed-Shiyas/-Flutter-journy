import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journalapp/screens/add_entry_Screen.dart';
import 'package:journalapp/screens/readListScreen.dart';
import '../constants.dart';
import '../components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: w,
            height: h,
            decoration: kScreenBg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JournyTitle(),
                SizedBox(height: h * 0.025),
                Image(
                  image: AssetImage('images/diary.png'),
                  width: w * 0.51,
                  height: h * 0.23,
                ),
                SizedBox(
                  height: h * 0.08,
                ),
                JournyButton(
                  label: 'Read Entries',
                  fn: () async {
                    await FirebaseFirestore.instance
                        .collection('entries')
                        .get()
                        .then((snapshot) {
                      List<QueryDocumentSnapshot> docList = snapshot.docs;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadEntryList(docs: docList),
                        ),
                      );
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                JournyButton(
                  label: 'Add Entry',
                  fn: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEntryScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
