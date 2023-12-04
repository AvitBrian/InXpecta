import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/home/profile_page.dart';
import 'package:inxpecta/src/features/home/report_page.dart';
import 'package:inxpecta/src/models/reports_model.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:provider/provider.dart';

class ReportRoom extends StatefulWidget {
  const ReportRoom({super.key});

  @override
  State<ReportRoom> createState() => _ReportRoomState();
}

class _ReportRoomState extends State<ReportRoom> {
  final db = FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String, dynamic>>> reportsStream;
  late List<Map<String, dynamic>> photoUrls = [];
  late AuthStateProvider authStateProvider;
  TextEditingController searchController = TextEditingController();
  bool _isfiltering = false;

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
    authStateProvider = Provider.of<AuthStateProvider>(context, listen: true);

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Scaffold(
      backgroundColor: MyConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: MyConstants.primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: false,
                    barrierDismissible: true,
                    builder: (context) => const ProfilePage()));
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: authStateProvider.photoUrl == null ||
                          authStateProvider.photoUrl == " "
                      ? Image.asset("assets/images/avatar.png")
                      : Image.network(
                          authStateProvider.photoUrl!,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            // Handle the error here
                            return Image.asset('assets/images/avatar.png');
                          },
                        ),
                ),
              ),
            ),
            Text(
              "Welcome Back, ${authStateProvider.name?.split(' ').first}!",
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextButton(
              child: Image.asset("assets/images/adjust.png",
                  height: 25, width: 25),
              onPressed: () {
                setState(() {
                  _isfiltering = !_isfiltering;
                });
              },
            ),
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
                child: Column(
                  children: [
                    Visibility(
                      visible: _isfiltering,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            reportsStream = FirebaseFirestore
                                                .instance
                                                .collection("reports")
                                                .orderBy("sourceName",
                                                    descending: true)
                                                .snapshots();
                                          });
                                        },
                                        child: Text("by Name")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlinedButton(
                                        onPressed: () {
                                          setState(() {
                                            reportsStream = FirebaseFirestore
                                                .instance
                                                .collection("reports")
                                                .orderBy("time",
                                                    descending: true)
                                                .snapshots();
                                          });
                                        },
                                        child: Text("by Latest")),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlinedButton(
                                        onPressed: () {},
                                        child: Text("by Votes")),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MyConstants.screenHeight(context),
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: reportsData?.length,
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 4),
                                    child: ExpansionTileCard(
                                      baseColor: Colors.white,
                                      animateTrailing: true,
                                      elevation: 0,
                                      isThreeLine: true,
                                      leading: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: photoUrls.firstWhere(
                                                    (entry) =>
                                                        entry['uid'] ==
                                                        reportsData?[index]
                                                            ["uid"],
                                                    orElse: () => {
                                                          'photoUrl': null
                                                        })['photoUrl'] !=
                                                null
                                            ? NetworkImage(photoUrls.firstWhere((entry) =>
                                                entry['uid'] ==
                                                reportsData?[index]
                                                    ["uid"])['photoUrl'])
                                            : const AssetImage(
                                                    "assets/images/anonymous-profile.png")
                                                as ImageProvider<Object>?,
                                      ),
                                      title: photoUrls.firstWhere(
                                                  (entry) =>
                                                      entry['uid'] ==
                                                      reportsData?[index]
                                                          ["uid"],
                                                  orElse: () =>
                                                      {'name': null})['name'] !=
                                              null
                                          ? Text(
                                              photoUrls.firstWhere((entry) =>
                                                  entry['uid'] ==
                                                  reportsData?[index]
                                                      ["uid"])['name'],
                                              style: TextStyle(
                                                  color: MyConstants
                                                      .secondaryColor,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          : const Text("Anonymous"),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(reportsData?[index]["details"],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1),
                                          Text(
                                            "#${reportsData?[index]["sourceName"]}",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ButtonBar(
                                              alignment:
                                                  MainAxisAlignment.start,
                                              buttonHeight: 52.0,
                                              buttonMinWidth: 90.0,
                                              children: <Widget>[
                                                TextButton(
                                                  style: flatButtonStyle,
                                                  onPressed: () {},
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Icon(Icons
                                                          .arrow_drop_up_sharp),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Text(
                                                        'Up Vote',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ButtonBar(
                                              alignment:
                                                  MainAxisAlignment.start,
                                              buttonHeight: 52.0,
                                              buttonMinWidth: 90.0,
                                              children: <Widget>[
                                                TextButton(
                                                  style: flatButtonStyle,
                                                  onPressed: () {},
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Icon(Icons
                                                          .arrow_drop_down_sharp),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Text(
                                                        'down Vote',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ));
          }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: MyConstants.primaryColor,
        elevation: 2,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                  constraints: BoxConstraints(
                      maxHeight: MyConstants.screenHeight(context) * 0.8),
                  child: const ReportPage());
            },
            context: context,
          );
        },
        label: Row(
          children: [
            Text(
              "Report",
              style: TextStyle(color: MyConstants.secondaryColor),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.badge_outlined,
              color: MyConstants.secondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
