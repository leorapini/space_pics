import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../helpers/ui_helpers.dart';

class PicOfDayListItem extends StatelessWidget {
  const PicOfDayListItem({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.date,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 100,
          child: ImgThumbnail(imgUrl: imgUrl),
        ),
        const AddHorizontalSpace(10),
        ThumbnailDescription(title: title, date: date)
      ],
    );
  }
}

class ThumbnailDescription extends StatelessWidget {
  const ThumbnailDescription({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const AddVerticalSpace(5),
          Text(
            date,
          )
        ],
      ),
    );
  }
}

class ImgThumbnail extends StatelessWidget {
  const ImgThumbnail({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 55),
          child: CircularProgressIndicator(value: downloadProgress.progress),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey,
          child: const Icon(
            Icons.no_photography,
            size: 40,
            color: Colors.white,
          ),
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}