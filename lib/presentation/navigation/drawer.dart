import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:rse/all.dart';
import 'package:slider_button/slider_button.dart';

const defaultUrl =
    "https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg";

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => DrawerState();
}

class DrawerState extends State<MyDrawer> {
  late bool isDark = isDarkMode(context);

  void toggleTheme(themeModel) {
    setState(() {
      isDark = !isDark;
    });
    themeModel.toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: T(context, 'primaryContainer').withOpacity(0.7),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      color: Colors.grey[900],
                      child: DrawerHeader(
                        decoration: const BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Royal Stock Exchange',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            StreamBuilder<User?>(
                              stream: FirebaseAuth.instance.userChanges(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(snapshot.data!.photoURL!),
                                  );
                                }
                                return const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(defaultUrl),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text(context.l.home),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text(context.l.investing),
                          onTap: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ListTile(
                          title: Text(context.l.account),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text(context.l.settings),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Consumer<ThemeModel>(
                          builder: (context, themeModel, _) {
                            return Toggler(
                              type: 'theme',
                              value: isDark,
                              onChanged: (newValue) {
                                toggleTheme(themeModel);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: T(context, 'inversePrimary'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 40,
                    ),
                    child: Center(
                      child: SliderButton(
                        width: 125,
                        height: 30,
                        shimmer: false,
                        buttonSize: 30,
                        highlightedColor: Colors.red,
                        action: () {
                          Navigator.of(context).pop();
                        },
                        label: Text(
                          context.l.sign_out,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
