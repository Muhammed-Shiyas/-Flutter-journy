import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:journalapp/components.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({Key? key}) : super(key: key);
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  TextEditingController titleControl = TextEditingController();
  TextEditingController entryControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: kScreenBg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              JournyTitle(),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w * 0.8,
                padding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                decoration: kTextField,
                child: Center(
                  child: TextFormField(
                    controller: titleControl,
                    cursorColor: Colors.white,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Entry Title*',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  width: w * 0.8,
                  padding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    reverse: entryControl.text.length > 20 ? true : false,
                    child: Center(
                      child: TextFormField(
                        controller: entryControl,
                        cursorColor: Colors.white,
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Create new entry',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              JournyButton(
                  label: "SAVE",
                  fn: () async {
                    if (titleControl.text.isEmpty ||
                        entryControl.text.isEmpty) {
                      print("please enter title and entry");
                    } else {
                      await FirebaseFirestore.instance
                          .collection('entries')
                          .add({
                            'Title': titleControl.text,
                            'Entry': entryControl.text,
                            'date': DateFormat.yMMMEd()
                                .add_jm()
                                .format(DateTime.now()),
                          })
                          .then((value) => showFireBaseAlert(context))
                          .catchError((error) => showErrorAlert(context));
                      titleControl.clear();
                      entryControl.clear();
                    }
                  }),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showFireBaseAlert(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('ok'),
    );
    AlertDialog alert = AlertDialog(
      title: Text(' Data Upload Status'),
      content: Text("Entry Added Successfully"),
      actions: [
        okButton,
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  showErrorAlert(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('ok'),
    );
    AlertDialog alert = AlertDialog(
      title: Text(' Something Went wrong'),
      content: Text("Entry Not Added Due To An Error"),
      actions: [
        okButton,
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  @override
  void dispose() {
    titleControl.dispose();
    entryControl.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
