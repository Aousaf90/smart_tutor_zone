import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/AuthenticationPage/userModel.dart';
import 'package:smart_tutor_zone/Courses/courseHelper.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/Pages/homePage.dart';

class courseChatRoom extends StatefulWidget {
  courseChatRoom({required this.course_detail});
  Map course_detail;

  @override
  State<courseChatRoom> createState() => _courseChatRoomState();
}

class _courseChatRoomState extends State<courseChatRoom> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  sendMessage(String send_by) {
    courseHelperSendMessage(
        widget.course_detail['category'],
        widget.course_detail['subCategory'],
        widget.course_detail['name'],
        send_by,
        controller.text);
  }

  @override
  Widget build(BuildContext context) {
    String course_name = widget.course_detail['name'];
    return Scaffold(
      backgroundColor: Color(0xffF5F9FF),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffF5F9FF),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(course_name, style: TextStyle(color: Color(0xff0059F5))),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text("Chat Room",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent)),
              ),
              Divider(),
              SizedBox(height: 10),
              Container(height: 550, child: _buildMessageList()),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Type Here...",
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      sendMessage(
                          Provider.of<StudentModel>(context, listen: false)
                              .email_detail[0]);
                      controller.text = "";
                    },
                    icon: Icon(
                      Icons.send,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: getCourseChat(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageDisplayBox(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageDisplayBox(doc) {
    Map document_data = doc.data() as Map<String, dynamic>;
    String my_email =
        Provider.of<StudentModel>(context, listen: false).email_detail[0];

    Alignment alignment = (document_data['sendBy'] == my_email)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    BorderRadius borderRadius = (document_data['sendBy'] == my_email)
        ? BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20))
        : (BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)));
    return Container(
        alignment: alignment,
        child: Column(
          children: [
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal),
                ],
                color: Color(
                  0xff0059F5,
                ),
                borderRadius: borderRadius,
              ),
              child: Text(document_data['message'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Text(
              document_data['sendBy'],
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ));
  }

  Stream<QuerySnapshot> getCourseChat() {
    return FirebaseFirestore.instance
        .collection(
            "/Courses_Categories/${widget.course_detail['category']}/${widget.course_detail["subCategory"]}/${widget.course_detail['name']}/ChatRoom")
        .snapshots();
  }
}
