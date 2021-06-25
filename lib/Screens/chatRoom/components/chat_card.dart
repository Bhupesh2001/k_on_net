import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/components/profileImage.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

class ChatCard extends StatelessWidget {
  final doc;
  ChatCard(this.doc);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SharedPrefHelper.myUid() != doc['id']
        ? InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessageScreen(doc)));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * (0.045 - 0.008),
                  vertical: size.width * 0.045),
              child: CardRow(
                name: doc['name'],
                isOnline: doc['isOnline'],
                senderMe: doc['id'] == SharedPrefHelper.myUid(),
                messageTime: '',
                doc: doc,
              ),
            ),
          )
        : SizedBox.shrink();
  }
}

class CardRow extends StatelessWidget {
  const CardRow({
    Key key,
    @required this.name,
    @required this.isOnline,
    @required this.senderMe,
    @required this.messageTime,
    @required this.doc,
  }) : super(key: key);

  final String name;
  final bool isOnline; //doc['isOnline']
  final bool senderMe;
  final String messageTime;
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0, bottom: 5),
              child: ProfileImage(),
            ),
            if (isOnline)
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent,
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 1.8),
                  ),
                ),
              )
          ],
        ),
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.width * (0.045 - 0.008)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: size.width * 0.012),
                // Opacity(
                //   opacity: 0.64,
                //   child: FutureBuilder(
                //     future: FirebaseFirestore.instance
                //         .collection("Messages")
                //         .doc(FireStoreHelper.getGroupChatId(doc))
                //         .collection(FireStoreHelper.getGroupChatId(doc))
                //         .doc('lastMessages')
                //         .get(),
                //     builder: (BuildContext context,
                //         AsyncSnapshot<dynamic> snapshot) {
                //       if (snapshot.hasData && snapshot.data != null)
                //         return Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text(
                //               (snapshot.data)['message'] ?? '',
                //               style: TextStyle(fontSize: 15),
                //               maxLines: 1,
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //             if ((snapshot.data)['time'] != null)
                //               Opacity(
                //                 opacity: 0.64,
                //                 child: Text(timeInHourMinFormat(
                //                     (snapshot.data)['time'])),
                //               )
                //           ],
                //         );
                //       else
                //         return Text('');
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
