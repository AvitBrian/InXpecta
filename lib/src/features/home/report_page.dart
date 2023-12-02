import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/components/expandable_texfield.dart';
import 'package:inxpecta/src/features/authentication/components/textfield.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late AuthStateProvider authStateProvider;
  TextEditingController sourceNameController = TextEditingController();
  TextEditingController sourceDetailsController = TextEditingController();
  String sourceName = "";
  String sourceDetails = "";
  late DateTime timestamp;

  final db = FirebaseFirestore.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sourceNameController.dispose();
    sourceDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authStateProvider = Provider.of<AuthStateProvider>(context, listen: true);

    Future sendReport() async {
      sourceName = sourceNameController.text.trim().toUpperCase();
      sourceDetails = sourceDetailsController.text.trim();
      timestamp = DateTime.now().toLocal();
      if (sourceName.isNotEmpty && sourceDetails.isNotEmpty) {
        try {
          await db.collection("reports").add({
            "sourceName": sourceName,
            "sourceDetails": sourceDetails,
            "time": timestamp,
            "uid": authStateProvider.uid
          });
          QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
              .collection("sources")
              .where("source_name", isEqualTo: sourceName)
              .get();
          print("THE SHIT IS: ${querySnapshot.docs.length}");

          // Check if there are any documents with the same sourceName
          if (querySnapshot.docs.isEmpty) {
            // No matching documents found, add the new source
            await db.collection("sources").add({
              "source_name": sourceName,
              "source_notoriety": 1,
              "status": "active"
            });
          }

          // Clear the controllers after sending the report
          sourceNameController.clear();
          sourceDetailsController.clear();

          //show a success message or navigate to another screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Report sent successfully')),
          );
        } catch (error) {
          print('Error sending report: $error');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyConstants.primaryColor,
          titleTextStyle:
              TextStyle(fontSize: 20, color: MyConstants.secondaryColor),
          title: Text(
            authStateProvider.name ?? "anonymous",
          ),
        ),
        body: Container(
          color: MyConstants.backgroundColor,
          height: MyConstants.screenHeight(context),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MyConstants.screenHeight(context) * 0.8,
                child: Column(
                  children: [
                    MyTextField(
                      hintText: "Source",
                      controller: sourceNameController,
                      roundness: BorderRadius.circular(15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                        child: MyExpandableTextField(
                      hintText: "Details",
                      controller: sourceDetailsController,
                    )),
                    const SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            sendReport();
            Navigator.pop(context);
          },
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(7), // Adjust the border radius as needed
          ),
          label: const Row(
            children: [
              Text("Send"),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.send_outlined)
            ],
          ),
          backgroundColor: MyConstants.primaryColor,
        ));
  }
}
