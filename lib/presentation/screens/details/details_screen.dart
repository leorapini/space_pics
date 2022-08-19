import 'package:flutter/material.dart';
import 'package:space_pics/presentation/constants/ui_standarts.dart';
import 'package:space_pics/presentation/helpers/ui_helpers.dart';
import 'package:space_pics/presentation/screens/details/widgets/image_widget.dart';

import '../../../domain/entities/pic_of_day.dart';

class DetailsScreenParams {
  final PicOfDay picOfDay;
  final bool offline;

  DetailsScreenParams({
    required PicOfDay this.picOfDay,
    required bool this.offline,
  });
}

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  final DetailsScreenParams params;

  DetailsScreen({required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 400,
            child: ImgLarge(
                imgUrl: params.picOfDay.imgUrl,
                date: params.picOfDay.date,
                offline: params.offline),
          ),
          Padding(
            padding: const EdgeInsets.all(stdPaddingValue),
            child: Column(
              children: [
                Text(
                  params.picOfDay.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
                AddVerticalSpace(5),
                Text(params.picOfDay.date),
                AddVerticalSpace(20),
                Text(
                  params.picOfDay.explanation,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                AddVerticalSpace(50),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
