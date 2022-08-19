import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    isConnected(context);
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
            const AddVerticalSpace(60),
            Column(
              children: [
                const Text(
                  'SpacePics',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey,
                    letterSpacing: -2.5,
                  ),
                ),
                BlocBuilder<PicOfDayListBloc, PicOfDayListState>(
                  builder: (context, state) {
                    if (state is PicOfDayListHasDataOffline) {
                      return const Text(
                        'Offline Mode',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange,
                          letterSpacing: 0,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
            const AddVerticalSpace(30),
            BlocBuilder<PicOfDayListBloc, PicOfDayListState>(
                builder: (context, state) {
              return TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter date (YYYY-MM-DD) or keyword',
                  hintStyle: TextStyle(fontSize: 14.5),
                ),
                onSubmitted: (String value) {
                  if (state is PicOfDayListHasDataOffline) {
                    context
                        .read<PicOfDayListBloc>()
                        .add(OnSearchSubmittedOffline(value: value));
                  } else {
                    context
                        .read<PicOfDayListBloc>()
                        .add(OnSearchSubmitted(value: value));
                  }
                },
              );
            }),
            const AddVerticalSpace(30),
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
                          date: state.picOfDayList[i].date,
                          offline: false,
                        ),
                      );
                    }),
                  ),
                );
              } else if (state is PicOfDayListHasDataOffline) {
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
                          date: state.picOfDayList[i].date,
                          offline: true,
                        ),
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

  Future<void> isConnected(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        context.read<PicOfDayListBloc>().add(OnInitialState());
      } else {
        context.read<PicOfDayListBloc>().add(OnInitialStateOffline());
      }
    } on SocketException catch (_) {
      context.read<PicOfDayListBloc>().add(OnInitialStateOffline());
    }
  }
}
