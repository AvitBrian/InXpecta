import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inxpecta/src/features/home/report_page.dart';
import 'package:inxpecta/src/models/reports_model.dart';
import 'package:inxpecta/src/utils/constants.dart';

class ReportRoom extends StatefulWidget {
  const ReportRoom({super.key});

  @override
  State<ReportRoom> createState() => _ReportRoomState();
}

class _ReportRoomState extends State<ReportRoom> {
  final db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> reportsStream;
  late List<Map<String, dynamic>> photoUrls = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reportsStream = FirebaseFirestore.instance
        .collection("reports")
        .orderBy("time", descending: true)
        .snapshots();
    db.collection("users").snapshots().listen((snapshot) {
      // Process the data here
      List<Map<String, dynamic>> userFields = snapshot.docs.map((e) {
        return {
          'uid': e['uid'],
          'photoUrl': e['photoUrl'],
          'name': e['name'],
        };
      }).toList();

      if (mounted) {
        setState(() {
          photoUrls = userFields;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MyConstants.primaryColor,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Scaffold(
      backgroundColor: MyConstants.navColor,
      appBar: AppBar(
        backgroundColor: MyConstants.primaryColor,
        automaticallyImplyLeading: false,
        title: const Text("Reports"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.filter_list),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: reportsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                    "Sorry there was an error fetching some data... refresh"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final reportsData = snapshot.data?.docs
                .map((e) => ReportsModel.fromSnapShot(e).toJson())
                .toList();

            return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                    itemCount: reportsData?.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: ExpansionTileCard(
                          animateTrailing: true,
                          elevation: 0,
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: photoUrls.firstWhere(
                                        (entry) =>
                                            entry['uid'] ==
                                            reportsData?[index]["uid"],
                                        orElse: () =>
                                            {'photoUrl': null})['photoUrl'] !=
                                    null
                                ? NetworkImage(photoUrls.firstWhere((entry) =>
                                    entry['uid'] ==
                                    reportsData?[index]["uid"])['photoUrl'])
                                : const AssetImage(
                                        "assets/images/noprofile.png")
                                    as ImageProvider<Object>?,
                          ),
                          title: photoUrls.firstWhere(
                                      (entry) =>
                                          entry['uid'] ==
                                          reportsData?[index]["uid"],
                                      orElse: () => {'name': null})['name'] !=
                                  null
                              ? Text(photoUrls.firstWhere((entry) =>
                                  entry['uid'] ==
                                  reportsData?[index]["uid"])['name'])
                              : const Text("John"),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reportsData?[index]["details"],
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              Text(
                                "#${reportsData?[index]["sourceName"]}",
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            const Divider(
                              thickness: 1.0,
                              height: 1.0,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  reportsData?[index]["details"],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 16),
                                ),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              buttonHeight: 52.0,
                              buttonMinWidth: 90.0,
                              children: <Widget>[
                                TextButton(
                                  style: flatButtonStyle,
                                  onPressed: () {},
                                  child: const Column(
                                    children: <Widget>[
                                      Icon(Icons.arrow_drop_up_sharp),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Text('close'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }));
          }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: MyConstants.primaryColor,
        elevation: 2,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportPage()),
          );
        },
        label: const Row(
          children: [
            Text("Send Report"),
            SizedBox(width: 5),
            Icon(Icons.ios_share_rounded)
          ],
        ),
      ),
    );
  }
}
