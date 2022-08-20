import 'package:flutter/material.dart';

import '../../../../domain/entities/pic_of_day.dart';
import '../../../helpers/vertical_horizontal_spaces.dart';
import '../../detail/details_screen.dart';
import '../../shared_widgets/images.dart';

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
        Navigator.of(context).pushNamed(DetailScreen.routeName,
            arguments: DetailScreenParams(
              picOfDay: picOfDay,
              offline: offline,
            ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 100,
            child: ImgThumbnail(
              imgUrl: picOfDay.imgUrl,
              date: picOfDay.date,
              offline: offline,
            ),
          ),
          const AddHorizontalSpace(10),
          ThumbnailDescription(
            title: picOfDay.title,
            date: picOfDay.date,
          )
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

  static const TextStyle titleStyle = TextStyle(
    fontSize: 16.5,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
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
