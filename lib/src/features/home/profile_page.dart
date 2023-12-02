import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/screens/auth_screen.dart';
import 'package:inxpecta/src/utils/constants.dart';
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MyConstants.primaryColor,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    authStateProvider = Provider.of<AuthStateProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyConstants.primaryColor,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: IconButton(
              iconSize: 35,
              onPressed: () {
                context.read<AuthStateProvider>().signOut();
                nextScreenReplacement(context, const AuthScreen());
              },
              icon: const Icon(Icons.exit_to_app_rounded),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: Image.network(
                    authStateProvider.photoUrl ??
                        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fblank%2520profile%2520picture%2F&psig=AOvVaw3H0NGRErZig7PEA9hE78lD&ust=1701369702394000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCOiz5pzu6YIDFQAAAAAdAAAAABAD",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome, ${authStateProvider.name}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                authStateProvider.email ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for editing profile
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyConstants.primaryColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
