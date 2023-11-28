import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/screens/auth_screen.dart';
import 'package:inxpecta/src/utils/next_screen.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AuthStateProvider authStateProvider;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authStateProvider = Provider.of<AuthStateProvider>(context, listen: true);

    return SizedBox.expand(
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    "${authStateProvider.photoUrl}",
                    height: 50,
                    width: 50,
                  ),
                ),
                Text(
                  "Welcome, ${authStateProvider.name}",
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () {
                          context.read<AuthStateProvider>().signOut();
                          nextScreenReplacement(context, const AuthScreen());
                        },
                        icon: const Icon(Icons.exit_to_app_rounded))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
