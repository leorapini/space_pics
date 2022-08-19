import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../data/constants/urls_and_paths.dart';
import '../../../../domain/entities/pic_of_day.dart';
import '../../../helpers/ui_helpers.dart';
import '../../details/details_screen.dart';

class PicOfDayListItem extends StatelessWidget {
  const PicOfDayListItem({
    Key? key,
    required this.picOfDay,
    required this.offline,
  }) : super(key: key);

  final PicOfDay picOfDay;
  final bool offline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailsScreen.routeName,
            arguments:
                DetailsScreenParams(picOfDay: picOfDay, offline: offline));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 100,
            child: ImgThumbnail(
                imgUrl: picOfDay.imgUrl, date: picOfDay.date, offline: offline),
          ),
          const AddHorizontalSpace(10),
          ThumbnailDescription(title: picOfDay.title, date: picOfDay.date)
        ],
      ),
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
      child: offline == false
          ? CachedNetworkImage(
              imageUrl: imgUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 55),
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
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
            )
          : FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(
                OfflineImages.getOfflineImgPath(date),
                errorBuilder: ((context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: const Icon(
                      Icons.no_photography,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
            ),
    );
  }
}
