import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:k_on_net/components/loadingIndicator.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({Key key}) : super(key: key);

  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  x() {
    FirebaseFirestore.instance.collection("").doc().get().asStream();
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      '9999991998',
      '8888888888',
      '7906573815',
      '7253018338',
      '7253018338',
      '7777777777',
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < list.length; i++)
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Users")
                    .where("phone", isEqualTo: list[i])
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return LoadingIndicator(isLoading: true);
                  if (snapshot.hasData && snapshot.data.size > 0) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text((snapshot.data.docs[0])['name'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 32)),
                          SizedBox(height: 30),
                          Text((snapshot.data.docs[0])['phone'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 32)),
                        ],
                      ),
                    );
                  } else
                    return SizedBox.shrink();
                },
              ),
          ],
        ),
      ),
    );
  }
}
