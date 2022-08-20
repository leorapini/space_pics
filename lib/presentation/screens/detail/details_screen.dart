import 'package:flutter/material.dart';

import '../../../domain/entities/pic_of_day.dart';
import '../../constants/ui_standard_values.dart';
import '../../helpers/ui_helpers.dart';
import '../shared_widgets/images.dart';

class DetailScreenParams {
  final PicOfDay picOfDay;
  final bool offline;

  DetailScreenParams({
    required this.picOfDay,
    required this.offline,
  });
}

class DetailScreen extends StatelessWidget {
  static const routeName = '/details';

  final DetailScreenParams params;
  DetailScreen({required this.params});

  static const TextStyle titleStyle = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87);

  static const TextStyle explanationStyle = TextStyle(
    fontSize: 15,
    color: Colors.black87,
  );

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
                  style: titleStyle,
                ),
                const AddVerticalSpace(5),
                Text(params.picOfDay.date),
                const AddVerticalSpace(20),
                Text(
                  params.picOfDay.explanation,
                  style: explanationStyle,
                ),
                const AddVerticalSpace(50),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
