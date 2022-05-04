// ignore_for_file: camel_case_types, unrelated_type_equality_checks

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class contact_page extends StatefulWidget {
  final String contactEmail;
  const contact_page({Key? key, required this.contactEmail}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return contact_page_state();
  }
}

class contact_page_state extends State<contact_page> {
  late TextEditingController _emailController;
  late TextEditingController _subjectController;
  late TextEditingController _questionController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _questionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: Colors.grey.shade200),
                        alignment: Alignment.center,
                        child:
                            Icon(Icons.arrow_back, color: Colors.grey.shade600),
                      )),
                  const Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 40,
                    height: 40,
                  )
                ],
              ),
              const SizedBox(height: 60),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: const EdgeInsets.only(left: 50, right: 50),
                padding: const EdgeInsets.only(left: 25, right: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  controller: _emailController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Contact Email'),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                margin: const EdgeInsets.only(left: 50, right: 50),
                padding: const EdgeInsets.only(left: 25, right: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  controller: _subjectController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Subject'),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                margin: const EdgeInsets.only(left: 50, right: 50),
                padding: const EdgeInsets.only(left: 25, right: 15),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: TextField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type Your Question Here'),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: 100,
                height: 40,
                child: TextButton(
                  onPressed: () {
                    if (_emailController.text == '' ||
                        (_subjectController.text == '' ||
                            _questionController.text == '')) {
                      _showToast("cannot be empty");
                    }
                    if (!_validateEmail()) {
                      _showToast("email error");
                    } else {
                      _deliverContactFormToEmail().then((res) {});
                    }
                  },
                  child: const Text(
                    'Send',
                  ),
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    primary: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.only(left: 25, right: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _deliverContactFormToEmail() async {
    final Email email = Email(
      body: _questionController.text,
      subject: _subjectController.text,
      recipients: ['191abChoDi@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

    return null;
  }

  bool _validateEmail() {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(_emailController.text);
  }

  _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xFF76D6E1),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _subjectController.dispose();
    _questionController.dispose();
    super.dispose();
  }
}
