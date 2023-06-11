import 'package:fishing_lab/provider/auth_provider.dart';
import 'package:fishing_lab/screens/auth_screen.dart';
import 'package:fishing_lab/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ScreenDivider extends StatefulWidget {
  const ScreenDivider({super.key});

  @override
  State<ScreenDivider> createState() => _ScreenDividerState();
}

class _ScreenDividerState extends State<ScreenDivider> {
  // ignore: non_constant_identifier_names
  AuthProvider? auth_controller;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    auth_controller = Provider.of<AuthProvider>(context);
    auth_controller!.checkIsAuthed();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [const AuthScreen(), const HomeScreen()];
    return Observer(builder: (context) {
      final isAuthed = auth_controller!.isAuthed;
      return screens[isAuthed];
    });
  }
}
