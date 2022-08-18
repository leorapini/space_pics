import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_pics/helpers/format_functions.dart';

import '../../bloc/pic_of_day_list_bloc.dart';
import '../../bloc/pic_of_day_list_event.dart';
import '../../bloc/pic_of_day_list_state.dart';
import '../../helpers/ui_helpers.dart';
import 'widgets/pic_of_day_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final double paddingValue = 20;

  @override
  Widget build(BuildContext context) {
    context
        .read<PicOfDayListBloc>()
        .add(OnInitialState(startDate: '', endDate: ''));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(paddingValue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AddVerticalSpace(80),
            const Text(
              'SpacePics',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey),
            ),
            const AddVerticalSpace(40),
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Search by date (Ex. YYYY-MM-DD) or keywords',
              ),
              onSubmitted: (value) {
                context
                    .read<PicOfDayListBloc>()
                    .add(OnDateChanged(startDate: value, endDate: value));
              },
            ),
            const AddVerticalSpace(40),
            BlocBuilder<PicOfDayListBloc, PicOfDayListState>(
                builder: (context, state) {
              if (state is PicOfDayListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PicOfDayListHasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemCount: state.picOfDayList.length,
                    itemBuilder: ((context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: PicOfDayListItem(
                            imgUrl: state.picOfDayList[i].imgUrl,
                            title: state.picOfDayList[i].title,
                            date: state.picOfDayList[i].date),
                      );
                    }),
                  ),
                );
              } else if (state is PicOfDayListError) {
                return const Center(
                  child: Text('Whoops. There has been an error'),
                );
              } else {
                return const SizedBox();
              }
            }),
            const AddVerticalSpace(20),
          ],
        ),
      ),
    );
  }
}
