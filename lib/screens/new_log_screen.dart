import 'dart:io';
import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/constants/functions.dart';
import 'package:fishing_lab/provider/log_provider.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/auth_widgets/full_width_button.dart';
import 'package:fishing_lab/widgets/log_widgets/log_detail.dart';
import 'package:fishing_lab/widgets/log_widgets/log_fish.dart';
import 'package:fishing_lab/widgets/log_widgets/log_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewLogScreen extends StatefulWidget {
  static const route = '/new-log';
  const NewLogScreen({super.key});

  @override
  State<NewLogScreen> createState() => _NewLogScreenState();
}

class _NewLogScreenState extends State<NewLogScreen> {
  // ignore: non_constant_identifier_names
  LogProvider? log_controller;
  TextEditingController? _titleController;
  TextEditingController? _descrController;
  TextEditingController? _fishNameController;
  TextEditingController? _mController;
  TextEditingController? _cmController;
  TextEditingController? _kgController;
  TextEditingController? _gController;

  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descrController = TextEditingController();
    _fishNameController = TextEditingController();
    _mController = TextEditingController();
    _cmController = TextEditingController();
    _kgController = TextEditingController();
    _gController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController!.dispose();
    _descrController!.dispose();
    _fishNameController!.dispose();
    _mController!.dispose();
    _cmController!.dispose();
    _kgController!.dispose();
    _gController!.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log_controller = Provider.of<LogProvider>(context);
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: CustomAppBar(
          title: 'New Note',
          actionButtons: const [],
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            LogInput(text: 'Title', controller: _titleController!),
            const SizedBox(
              height: 20,
            ),
            LogInput(
                text: 'Description',
                controller: _descrController!,
                multilines: true),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: lightMainColor),
                  ),
                  child: TextButton.icon(
                      onPressed: _takePicture,
                      icon: const Icon(
                        CupertinoIcons.camera_viewfinder,
                        size: 30,
                        color: mainColor,
                      ),
                      label: const LocaleText(
                        'Picture',
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MM'),
                      )),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: _pickedImage != null
                        ? SizedBox(
                            width: 100,
                            height: 150,
                            child: Image.file(
                              _pickedImage!,
                              fit: BoxFit.contain,
                              width: double.infinity,
                            ),
                          )
                        : const Center(
                            child: LocaleText(
                              'No Picture',
                              style: TextStyle(color: mainColor, fontSize: 18),
                            ),
                          )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(children: [
                    const Row(
                      children: [
                        Flexible(
                          child: LocaleText(
                            'Describe Catch',
                            style: TextStyle(
                                fontSize: 26,
                                color: mainColor,
                                fontFamily: 'BNR'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LogInput(text: 'Fish', controller: _fishNameController!),
                  ]),
                ),
                const LogFish()
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                    child: LogDetail(
                        text: 'Fish Long',
                        icon: Icons.height_outlined,
                        callback: () => defineDetail(
                            context: context,
                            title: 'Fish Long',
                            mController: _mController!,
                            cmController: _cmController!))),
                const SizedBox(width: 10),
                Expanded(
                    child: LogDetail(
                        text: 'Fish Weight',
                        icon: Icons.scale_outlined,
                        callback: () => defineDetail(
                            context: context,
                            title: 'Fish Weight',
                            mController: _kgController!,
                            cmController: _gController!,
                            label1: 'Kg',
                            label2: 'Gr'))),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            FullWithButton(
                text: 'CREATE',
                callback: () {
                  // Create new Note
                  if (_titleController!.text.isEmpty ||
                      _descrController!.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar(
                        'OK',
                        'Fill in title and description fields',
                        () {},
                        Colors.red));
                    return;
                  }
                  if (_pickedImage == null) {
                    log_controller!.addToLogs(
                        title: _titleController!.text.trim(),
                        description: _descrController!.text.trim(),
                        fishName: _fishNameController!.text.trim(),
                        fishLong: double.parse(_mController!.text.trim().isEmpty
                                    ? '0'
                                    : _mController!.text.trim()) *
                                100 +
                            double.parse(_cmController!.text.trim().isEmpty
                                ? "0"
                                : _cmController!.text.trim()),
                        fishWeight: double.parse(
                                    _kgController!.text.trim().isEmpty
                                        ? "0"
                                        : _kgController!.text.trim()) *
                                1000 +
                            double.parse(_gController!.text.trim().isEmpty
                                ? '0'
                                : _gController!.text.trim()));
                  } else {
                    log_controller!.addToLogs(
                        title: _titleController!.text.trim(),
                        description: _descrController!.text.trim(),
                        image: _pickedImage,
                        fishName: _fishNameController!.text.trim(),
                        fishLong: double.parse(_mController!.text.trim().isEmpty
                                    ? '0'
                                    : _mController!.text.trim()) *
                                100 +
                            double.parse(_cmController!.text.trim().isEmpty
                                ? "0"
                                : _cmController!.text.trim()),
                        fishWeight: double.parse(
                                    _kgController!.text.trim().isEmpty
                                        ? "0"
                                        : _kgController!.text.trim()) *
                                1000 +
                            double.parse(_gController!.text.trim().isEmpty
                                ? '0'
                                : _gController!.text.trim()));
                  }
                  Navigator.pop(context);
                }),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      )),
    );
  }
}
