import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_tn_app/modules/messages.dart';
import 'package:flutter/material.dart';
class MessageWidget extends StatelessWidget {
  final Messages message;
  final bool isMe;
  final DocumentReference docs;
  const MessageWidget({@required this.message, @required this.isMe, @required this.docs});
  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);
    String getInitials(String name) => name.isNotEmpty
        ? name.trim().split(' ').map((l) => l[0]).take(3).join()
        : '';
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if(!isMe)
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.grey.shade300,
            child: Text(getInitials(message.sender), style: TextStyle(fontSize: 18, color: Colors.blue), ),
          ),
        InkWell(
          onLongPress: (){
            if(isMe){
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 5),
                content: Text('Bạn có muốn xóa tin nhắn?',style: TextStyle(color: Colors.black,),),
                backgroundColor: Colors.white,
                action: SnackBarAction(
                  label: 'Gỡ tin nhắn',
                  onPressed: (){
                    docs.delete();
                  },
                ),
              ));
            }
          },
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: 180),
            decoration: BoxDecoration(
                color: isMe ? Colors.blue.withOpacity(0.5) : Colors.black26,
                borderRadius: isMe
                    ? borderRadius.subtract(BorderRadius.only(bottomRight: radius, ))
                    : borderRadius.subtract(BorderRadius.only(bottomLeft: radius, ))
            ),
            child: buildMessage(),
          ),
        ),
      ],
    );
  }
  Widget buildMessage() => Column(
    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(
        message.message,
        style: TextStyle(color: Colors.black, fontSize: 20),
        textAlign: isMe ? TextAlign.end : TextAlign.start,
      )
    ],
  );
}
