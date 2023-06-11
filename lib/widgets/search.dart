import 'package:fishing_lab/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class Search extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String val) callback;
  final String placeholder;
  const Search(
      {super.key,
      required this.controller,
      required this.callback,
      this.placeholder = 'Search'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(bottom: 20, top: 15),
      child: CupertinoSearchTextField(
          backgroundColor: mainColor,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(CupertinoIcons.search),
          ),
          borderRadius: BorderRadius.circular(15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          placeholder: placeholder,
          controller: controller,
          onChanged: callback),
    );
  }
}
