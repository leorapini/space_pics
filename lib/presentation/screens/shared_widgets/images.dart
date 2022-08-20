import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/urls_and_paths.dart';

class ImgThumbnail extends StatelessWidget {
  const ImgThumbnail({
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: offline == true
          ? LocalImage(date: date)
          : InternetImage(imgUrl: imgUrl),
    );
  }
}

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
    return offline == true
        ? LocalImage(date: date)
        : InternetImage(imgUrl: imgUrl);
  }
}

class LocalImage extends StatelessWidget {
  const LocalImage({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Image.asset(
        OfflineImages.getOfflineImgPath(date),
        errorBuilder: ((context, error, stackTrace) {
          return const ErrorImage();
        }),
      ),
    );
  }
}

class InternetImage extends StatelessWidget {
  const InternetImage({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 55),
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const ErrorImage(),
      fit: BoxFit.cover,
    );
  }
}

class ErrorImage extends StatelessWidget {
  const ErrorImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey,
      child: const Icon(
        Icons.no_photography,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}
