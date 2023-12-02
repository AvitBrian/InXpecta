import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/charts/indicators.dart';
import 'package:inxpecta/src/charts/pieChart.dart';
import 'package:inxpecta/src/models/source_List_Model.dart';
import 'package:inxpecta/src/models/source_model.dart';
import 'package:inxpecta/src/utils/camel_case.dart';
import 'package:inxpecta/src/utils/constants.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> sources = [];
  late SourceModel source;
  late AnimationController _controller;

  final db = FirebaseFirestore.instance;
  bool _fetchingData = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 120),
    )..repeat();
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
        final sourceName = report.data()['sourceName'] as String?;
        if (sourceName != null) {
          sourceNameCountMap[sourceName] =
              (sourceNameCountMap[sourceName] ?? 0) + 1;
        }
      }
      sourceNameCountMap.forEach((key, value) {
        print("$value");
        for (var e in sources) {
          if (e["source_name"] == key) {
            db
                .collection("sources")
                .doc(e["id"])
                .update({"source_notoriety": value})
                .then((value) => print("updates complete!"))
                .catchError((error) => print("error: $error"));
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyConstants.primaryColor,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyConstants.primaryColor, MyConstants.navColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 5],
              tileMode: TileMode.clamp,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              // Add the app bar to the CustomScrollView.
              SliverAppBar(
                forceMaterialTransparency: true,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "#1 ${_fetchingData ? "Loading" : ""}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyConstants.textColor),
                    ),
                    Text(
                      "${_fetchingData ? "Loading" : sources[0]["source_name"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.withAlpha(255)),
                    )
                  ],
                ),
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RotationTransition(
                    filterQuality: FilterQuality.high,
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOutCubic,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Center(child: Pie(yourKeyValueList: sources)),
                      ),
                    ),
                  ),
                ),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: MyConstants.screenHeight(context) / 1.5,
                collapsedHeight: 300,
              ),
              // Next, create a SliverList
              SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                        height: 400,
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
                                    SizedBox(
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
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      height: 35,
                                                      width: 35,
                                                      child: Center(
                                                          child: Text(
                                                              "#${index + 1}"))),
                                                  title: Text(UsefulFunctions()
                                                      .ToCamelCase(
                                                          sources[index]
                                                              ["source_name"])),
                                                  subtitle: Text(
                                                    sources[index]["status"],
                                                    style: TextStyle(
                                                      color: sources[index]
                                                                  ["status"] ==
                                                              "active"
                                                          ? Colors.green
                                                          : Colors.red,
                                                    ),
                                                  ),
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
