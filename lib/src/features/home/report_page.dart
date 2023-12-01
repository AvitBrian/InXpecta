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
      sourceName = sourceNameController.text.trim();
      sourceDetails = sourceDetailsController.text.trim();
      if (sourceName.isNotEmpty && sourceDetails.isNotEmpty) {
        try {
          await db.collection("reports").add({
            "sourceName": sourceName,
            "sourceDetails": sourceDetails,
          });
          QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
              .collection("sources")
              .where("sourceName", isEqualTo: sourceName)
              .get();

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
            SnackBar(content: Text('Report sent successfully')),
          );
        } catch (error) {
          print('Error sending report: $error');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in all fields')),
        );
      }
    }

    return Scaffold(
        body: Container(
          color: MyConstants.backgroundColor,
          height: MyConstants.screenHeight(context),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(authStateProvider.name ?? "anonymous"))),
                Expanded(
                    child: MyTextField(
                  hintText: "Source",
                  controller: sourceNameController,
                )),
                const SizedBox(
                  height: 1,
                ),
                Expanded(
                    flex: 5,
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: sendReport,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(7), // Adjust the border radius as needed
          ),
          label: Row(
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
