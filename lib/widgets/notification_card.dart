import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';

import '../screens/comment_screen.dart';

class NotificationCard extends StatefulWidget {
  final snap;
  const NotificationCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      snap: widget.snap,
                    ),
                  ),
                ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: black38Color)
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:NetworkImage(widget.snap['photoURL']),
              radius: 18,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.snap['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: '  have just ${widget.snap['isLike'] ? "liked and" : "" } commented your post',
                            style: const TextStyle(
                              color: whiteColor,
                              fontSize: 14,
                            )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        'at ${DateFormat.Hm().format(
                          widget.snap['datePublished'].toDate(),
                        )} ${DateFormat.MEd().format(
                          widget.snap['datePublished'].toDate(),
                        )}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    
            
          ],
        ),
      ),
    );
  }
}
