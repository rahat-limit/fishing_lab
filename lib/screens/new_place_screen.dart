import 'package:cached_network_image/cached_network_image.dart';
import 'package:fishing_lab/provider/location_provider.dart';
import 'package:fishing_lab/widgets/appbar.dart';
import 'package:fishing_lab/widgets/auth_widgets/auth_input.dart';
import 'package:fishing_lab/widgets/auth_widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPlaceScreen extends StatefulWidget {
  final double lat;
  final double lng;
  const NewPlaceScreen({super.key, required this.lat, required this.lng});

  @override
  State<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<NewPlaceScreen> {
  // ignore: non_constant_identifier_names
  LocationProvider? location_controller;
  TextEditingController? controller;
  // ignore: non_constant_identifier_names
  String? image_path;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = TextEditingController();
    location_controller = Provider.of<LocationProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(
          title: 'New Point',
          actionButtons: [],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: location_controller!.getLocationImagePath(
                    lat: widget.lat,
                    lng: widget.lng,
                  ),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthInput(
                  controller: controller!,
                  text: 'Title',
                  callback: (String text) {}),
              const SizedBox(
                height: 20,
              ),
              FullWithButton(
                callback: () async {
                  if (controller!.value.text.trim().isNotEmpty) {
                    Navigator.pop(context);

                    await location_controller!.addToPlaces(
                        title: controller!.text.trim(),
                        lat: widget.lat,
                        lng: widget.lng);
                    // ignore: use_build_context_synchronously
                  } else {
                    return;
                  }
                },
                text: 'Set Point',
              )
            ],
          ),
        ),
      )),
    );
  }
}
