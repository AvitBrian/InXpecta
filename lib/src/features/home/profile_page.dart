import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/screens/auth_screen.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:inxpecta/src/utils/next_screen.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late YoutubePlayerController _controller;
  late AuthStateProvider authStateProvider;
  final videoUrl = "https://youtu.be/HxySrSbSY7o";

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(autoPlay: true));
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
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: MyConstants.primaryColor,
        title: Text(
          "My Profile",
          style: TextStyle(fontSize: 14),
        ),
        elevation: 0,
        actions: [
          const Text("Log out"),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
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
          const SizedBox(height: 30),
          const Text("Today's Video!"),
          const SizedBox(height: 20),
          Container(
            width: MyConstants.screenWidth(context) * .9,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          )
        ],
      ),
    );
  }
}
