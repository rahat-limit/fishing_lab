import 'package:fishing_lab/provider/log_provider.dart';
import 'package:fishing_lab/screens/new_log_screen.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/floating_action_button.dart';
import 'package:fishing_lab/widgets/log_widgets/log_item.dart';
import 'package:fishing_lab/widgets/menu/custom_drawer.dart';
import 'package:fishing_lab/widgets/screen_headline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LogScreen extends StatefulWidget {
  static const route = '/log';
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  // ignore: non_constant_identifier_names
  LogProvider? log_controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log_controller = Provider.of<LogProvider>(context);
    when((p0) => log_controller!.getLogs.length == 2, () {
      log_controller!.getDataFromLocalDB();
    });
  }

  void delete(String id) async {
    await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Are you sure you want to delete this point?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close')),
              TextButton(
                onPressed: () {
                  log_controller!.removeFromLogs(id: id);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(
          title: 'Catch Log',
          actionButtons: [],
        ),
      ),
      floatingActionButton: ActionButton(
        text: 'Create Note',
        path: 'assets/images/Hand.png',
        callback: () {
          Navigator.pushNamed(context, NewLogScreen.route);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const ScreenHeadline(text: 'Notes:'),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: Observer(builder: (context) {
            final logs = log_controller!.getLogs;
            if (logs.isEmpty) {
              return const SizedBox();
            }
            return ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return LogItem(
                  delete: () {
                    delete(logs[index].id);
                  },
                  log: logs[index],
                );
              },
            );
          }))
        ]),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
