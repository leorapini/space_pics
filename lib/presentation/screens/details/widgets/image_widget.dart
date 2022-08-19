import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/constants/urls_and_paths.dart';

class ImgLarge extends StatelessWidget {
  const ImgLarge({
    Key? key,
    required this.imgUrl,
    required this.date,
    required this.offline,
  }) : super(key: key);

  final String imgUrl;
  final String date;
  final bool offline;

  @override
  Widget build(BuildContext context) {
    return offline == false
        ? CachedNetworkImage(
            imageUrl: imgUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 55),
              child:
                  CircularProgressIndicator(value: downloadProgress.progress),
            ),
            errorWidget: (context, url, error) => Container(
              width: 200,
              color: Colors.grey,
              child: const Icon(
                Icons.no_photography,
                size: 40,
                color: Colors.white,
              ),
            ),
            fit: BoxFit.cover,
          )
        : FittedBox(
            fit: BoxFit.cover,
            child: Image.asset(
              OfflineImages.getOfflineImgPath(date),
              errorBuilder: ((context, error, stackTrace) {
                return Container(
                  width: 200,
                  color: Colors.grey,
                  child: const Icon(
                    Icons.no_photography,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          );
  }
}
