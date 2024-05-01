import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_tutor_zone/Pages/Models/student_model.dart';
import 'package:smart_tutor_zone/Pages/chat_room/course_chat_page.dart';
import 'package:smart_tutor_zone/style.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentModel>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
            width: double.infinity,
            color: Color(0xffF5F9FF),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: const Text(
                    "Chat Room",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0059F5)),
                  ),
                ),
                Divider(),
                ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 700,
                    child: ListView.builder(
                      itemCount: value.course_detail.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: Text(
                                  "${value.course_detail[index]['name']}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  "${value.course_detail[index]['subCategory']}"),
                              trailing: IconButton(
                                onPressed: () {
                                  redirectToChatRoom(
                                      context,
                                      value.course_detail[index]
                                          as Map<String, dynamic>);
                                },
                                icon: Icon(Icons.arrow_forward,
                                    color: Color(0xff0059F5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  redirectToChatRoom(
    context,
    Map<String, dynamic> course_data,
  ) async {
    WidgetStyle().NextScreen(
        context,
        courseChatRoom(
          course_detail: course_data,
        ));
  }
}
