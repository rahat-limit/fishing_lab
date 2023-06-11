import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishing_lab/constants/functions.dart';
import 'package:fishing_lab/screens/auth_screen.dart';
import 'package:fishing_lab/screens/forgot_screen.dart';
import 'package:fishing_lab/services/auth_service.dart';
import 'package:fishing_lab/widgets/account_widgets/account_button.dart';
import 'package:fishing_lab/widgets/account_widgets/description.dart';
import 'package:fishing_lab/widgets/account_widgets/info_item.dart';
import 'package:fishing_lab/widgets/account_widgets/verified.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/menu/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  static const route = '/account';
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? currentUser;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    checkFirstOpen();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  Future checkFirstOpen() async {
    await AuthService().isAuthed().then((authed) {
      if (!authed) {
        Navigator.pushNamed(context, AuthScreen.route);
      } else {
        currentUser = FirebaseAuth.instance.currentUser;
      }
    });
  }

  Future verify() async {
    await AuthService().verifyEmail().whenComplete(() async {
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar('OK', 'Succeeded, check your email.', () {}, Colors.green));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
          snackBar('OK', 'Error, Something went wrong.', () {}, Colors.red));
    });
  }

  void reset() {
    Navigator.pushNamed(context, ForgotScreen.route);
  }

  Future signout() async {
    await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Are you sure you want to leave this account?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close')),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .signOut()
                      .whenComplete(() => Navigator.pushReplacementNamed(
                          context, AuthScreen.route))
                      .onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar('OK',
                        'Error, Something went wrong.', () {}, Colors.red));
                  });
                },
                child: const Text(
                  'Leave',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: const CustomAppBar(
                  title: 'Account',
                  actionButtons: [],
                ),
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Image(
                      image: AssetImage('assets/images/man.png'),
                      width: 130,
                      height: 130,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Description(text: 'Info', icon: CupertinoIcons.person),
                  const SizedBox(
                    height: 15,
                  ),
                  InfoItem(text: currentUser!.email!, placeholder: 'Email: '),
                  const SizedBox(
                    height: 10,
                  ),
                  InfoItem(
                      text: currentUser!.displayName == null
                          ? 'No Name'
                          : currentUser!.displayName!,
                      placeholder: 'Name: '),
                  const SizedBox(
                    height: 15,
                  ),
                  const Description(
                      text: 'Settings', icon: CupertinoIcons.settings),
                  const SizedBox(
                    height: 10,
                  ),
                  currentUser!.emailVerified
                      ? const VerifiedEmail()
                      : AccountButton(
                          text: 'Verify Account',
                          icon: Icons.verified,
                          callback: verify,
                          color: const Color(0xff8FC277)),
                  const SizedBox(
                    height: 15,
                  ),
                  AccountButton(
                      text: 'Reset Password',
                      icon: Icons.edit,
                      callback: reset,
                      color: CupertinoColors.activeOrange),
                  const SizedBox(
                    height: 15,
                  ),
                  AccountButton(
                      text: 'Sign Out',
                      icon: Icons.edit,
                      callback: signout,
                      color: CupertinoColors.systemRed),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              )),
              drawer: const CustomDrawer(),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('You are not registered'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, AuthScreen.route),
                      child: const Text('Register'))
                ],
              ),
            );
          }
        });
  }
}
