import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/charts/indicators.dart';
import 'package:inxpecta/src/charts/pieChart.dart';
import 'package:inxpecta/src/models/source_List_Model.dart';
import 'package:inxpecta/src/models/source_model.dart';
import 'package:inxpecta/src/utils/constants.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<Map<String, dynamic>> sources = [];
  late SourceModel source;
  final db = FirebaseFirestore.instance;
  bool _fetchingData = false;

  @override
  void initState() {
    super.initState();
    _fetchingData = true;
    // Listen to changes in the "sources" collection
    db
        .collection("sources")
        .orderBy("source_notoriety", descending: true)
        .snapshots()
        .listen((snapshot) {
      // Process the data here

      final sourcesData =
          snapshot.docs.map((e) => SourceModel.fromSnapShot(e)).toList();

      SourceListModel sourceList = SourceListModel(sourcesList: sourcesData);
      _fetchingData = false;

      if (mounted) {
        setState(() {
          sources = sourceList.toJsonList();
        });
      }
    });
    db.collection("reports").snapshots().listen((snapshot) {
      final sourceNameCountMap = <String, int>{};

      for (var report in snapshot.docs) {
        final sourceName = report.data()?['sourceName'] as String?;
        if (sourceName != null) {
          sourceNameCountMap[sourceName] =
              (sourceNameCountMap[sourceName] ?? 0) + 1;
        }
      }
      sourceNameCountMap.forEach((key, value) {
        print("$value");
        sources.forEach((e) {
          if (e["source_name"] == key) {
            db
                .collection("sources")
                .doc(e["id"])
                .update({"source_notoriety": value})
                .then((value) => print("updates complete!"))
                .catchError((error) => print("error: $error"));
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyConstants.backgroundColor,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyConstants.backgroundColor, MyConstants.navColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 2],
              tileMode: TileMode.clamp,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              // Add the app bar to the CustomScrollView.
              SliverAppBar(
                forceMaterialTransparency: true,
                centerTitle: true,
                title: Text(
                  "#1 ${_fetchingData ? "Loading" : sources[0]["source_name"]}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyConstants.textColor),
                ),
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(child: Pie(yourKeyValueList: sources)),
                    ),
                  ),
                ),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: MyConstants.screenHeight(context) / 1.5,
                collapsedHeight: 100,
              ),
              // Next, create a SliverList
              SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                        height: 450,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          color: Colors.white.withAlpha(170),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                height: 10,
                                width: 40,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: MyConstants.screenWidth(context),
                                      child: Indicators(
                                        yourKeyValueList: sources,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: sources.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Card(
                                                elevation: 0,
                                                color: MyConstants.navColor,
                                                child: ListTile(
                                                  dense: true,
                                                  leading: Container(
                                                      decoration: BoxDecoration(
                                                          color: MyConstants
                                                              .primaryColor
                                                              .withOpacity(.3),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      height: 35,
                                                      width: 35,
                                                      child: Center(
                                                          child: Text(
                                                              "${index + 1}"))),
                                                  title: Text(
                                                      "${sources[index]["source_name"] ?? "Loading"}"),
                                                  trailing: Text(
                                                      "Notoriety: ${sources[index]["source_notoriety"].toStringAsFixed(0)} "),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  )),
            ],
          ),
        ));
  }
}
