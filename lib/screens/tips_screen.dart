import 'package:fishing_lab/provider/tip_provider.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/menu/custom_drawer.dart';
import 'package:fishing_lab/widgets/screen_headline.dart';
import 'package:fishing_lab/widgets/tip_widgets/tip_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TipsScreen extends StatefulWidget {
  static const route = '/tip';
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  // ignore: non_constant_identifier_names
  TipProvider? tip_controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tip_controller = Provider.of<TipProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(
          title: 'Tips',
          actionButtons: [],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const ScreenHeadline(text: 'Articles:'),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: Observer(builder: (context) {
              final tips = tip_controller!.getTips;
              return ListView.builder(
                  itemCount: tips.length,
                  itemBuilder: (context, index) {
                    return TipItem(tip: tips[index]);
                  });
            }))
          ])),
      drawer: const CustomDrawer(),
    );
  }
}
