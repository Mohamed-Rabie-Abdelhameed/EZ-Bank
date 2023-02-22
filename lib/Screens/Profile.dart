import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../controllers/profileController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main.dart';
import '../models/Account.dart';
import '../repository/authRepository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    bool isDark = themeManager.themeMode == ThemeMode.dark;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(LineIcons.angleLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: Icon(isDark ? LineIcons.sun : LineIcons.moon),
              onPressed: () {
                themeManager.toggleTheme(isDark);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder(
                  future: profileController.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        Account userData = snapshot.data as Account;
                        return Column(children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.7),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/man.png',
                                              ),
                                              fit: BoxFit.cover))),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Icon(
                                    LineIcons.alternatePencil,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(userData.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(userData.email,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey)),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: 200,
                              height: 50,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/edit');
                                },
                                child: Text("Edit Profile",
                                    style: TextStyle(fontSize: 18)),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: isDark
                                        ? Color(0xFFFFD23F)
                                        : Color(0xFF5EBC66),
                                    shape: StadiumBorder()),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          ProfileMenuWidget(
                              title: "Settings",
                              icon: LineIcons.cog,
                              onPress: () {
                                Navigator.pushNamed(context, "/settings");
                              }),
                          ProfileMenuWidget(
                              title: "Billing Details",
                              icon: LineIcons.creditCard,
                              onPress: () {
                                Navigator.pushNamed(context, '/billing');
                              }),
                          ProfileMenuWidget(
                              title: "Help",
                              icon: LineIcons.questionCircle,
                              onPress: () {
                                Navigator.pushNamed(context, '/help');
                              }),
                          ProfileMenuWidget(
                              title: "About",
                              icon: LineIcons.infoCircle,
                              onPress: () {
                                Navigator.pushNamed(context, '/about');
                              }),
                          ProfileMenuWidget(
                              title: "Logout",
                              icon: LineIcons.alternateSignOut,
                              onPress: () {
                                AuthRepository.instance.signOut();
                              },
                              endIcon: false,
                              textColor: Colors.red),
                        ]);
                      }
                    } else {
                      return Center(
                child: SpinKitThreeInOut(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                )
              );
                    }
                    return const Center(child: Text("No Data"));
                  },
                ))));
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    var isDark = themeManager.themeMode == ThemeMode.dark;
    var iconColor = isDark ? Colors.yellow : Colors.green;
    return ListTile(
        onTap: onPress,
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100)),
          child: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
        trailing: endIcon
            ? Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  LineIcons.angleRight,
                  color: Colors.grey,
                  size: 18,
                ),
              )
            : null);
  }
}
