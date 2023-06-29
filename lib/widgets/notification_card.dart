import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatefulWidget {
  final snap;
  const NotificationCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            backgroundImage:AssetImage('assets/default-profile.jpg'),
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
                          text: 'username',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '  have been commented your post',
                          
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: Text(
                      // 'at ${DateFormat.Hm().format(
                      //   widget.snap['datePublished'].toDate(),
                      // )} ${DateFormat.MEd().format(
                      //   widget.snap['datePublished'].toDate(),
                      // )}',
                      '21/02/2001',
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
    );
  }
}
