import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/screens/auth_screen.dart';
import 'package:inxpecta/src/utils/next_screen.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
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

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: 60,
                    width: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            const AssetImage("assets/images/noprofile.png"),
                        child: Image.network(
                          authStateProvider.photoUrl ??
                              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fblank%2520profile%2520picture%2F&psig=AOvVaw3H0NGRErZig7PEA9hE78lD&ust=1701369702394000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCOiz5pzu6YIDFQAAAAAdAAAAABAD",
                        ),
                      ),
                    )),
                SizedBox(
                  width: 5,
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
