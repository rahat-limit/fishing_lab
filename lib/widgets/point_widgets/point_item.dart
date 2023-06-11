import 'package:cached_network_image/cached_network_image.dart';
import 'package:fishing_lab/constants/colors.dart';
import 'package:fishing_lab/models/place_model.dart';
import 'package:flutter/material.dart';

class PointItem extends StatelessWidget {
  final Place place;
  final String path;
  final VoidCallback callback;
  final VoidCallback delete;
  final VoidCallback navigationCallback;
  const PointItem(
      {super.key,
      required this.place,
      required this.path,
      required this.callback,
      required this.navigationCallback,
      required this.delete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: delete,
      onTap: callback,
      onLongPress: navigationCallback,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          place.title,
                          maxLines: 1,
                          style: const TextStyle(
                            color: mainColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MM',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          place.location.address,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: mainColor,
                            fontSize: 15,
                            fontFamily: 'MR',
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: path,
                height: 100,
                width: 100,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
