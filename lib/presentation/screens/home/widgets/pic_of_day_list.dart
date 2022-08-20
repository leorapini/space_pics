import 'package:flutter/material.dart';

import '../../../../domain/entities/pic_of_day.dart';
import 'pic_of_day_list_item.dart';

class PicOfDayList extends StatelessWidget {
  final List<PicOfDay> picOfDayList;

  const PicOfDayList({super.key, required this.picOfDayList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemCount: picOfDayList.length,
        itemBuilder: ((context, i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: PicOfDayListItem(
              picOfDay: picOfDayList[i],
              offline: false,
            ),
          );
        }),
      ),
    );
  }
}
