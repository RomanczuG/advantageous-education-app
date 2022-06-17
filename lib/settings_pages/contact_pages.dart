import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailSender extends StatefulWidget {
  const EmailSender(
      {Key? key, required this.emailAddress, required this.subjectMessage})
      : super(key: key);
  final String emailAddress;
  final String subjectMessage;

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  final user = FirebaseAuth.instance.currentUser!;

  final _bodyController = TextEditingController(
    text: 'Write your email',
  );

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: widget.subjectMessage,
      recipients: [widget.emailAddress],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Message was sent!';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Send message to our team'),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // Button Send Email

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    primary: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  onPressed: send,
                  child: Center(
                      child: Text(
                    "Send your message",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
