import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/pic_of_day_list_bloc.dart';
import '../../bloc/pic_of_day_list_event.dart';
import '../../bloc/pic_of_day_list_state.dart';
import '../../helpers/vertical_horizontal_spaces.dart';
import 'widgets/pic_of_day_list.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  final double paddingValue = 20;

  static const TextStyle logoStyle = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w800,
    color: Colors.grey,
    letterSpacing: -2.5,
  );

  static const TextStyle offlineStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.orange,
    letterSpacing: 0,
  );

  @override
  Widget build(BuildContext context) {
    connectionCheck(context);
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
            const AddVerticalSpace(50),
            Column(
              children: [
                const Text(
                  'SpacePics',
                  style: logoStyle,
                ),
                BlocBuilder<PicOfDayListBloc, PicOfDayListState>(
                  builder: (context, state) {
                    if (state is PicOfDayListHasDataOffline) {
                      return const Text(
                        'Offline Mode',
                        style: offlineStyle,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const AddVerticalSpace(10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    connectionCheck(context);
                  },
                  child: const Text(
                    'See & Refresh List',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const AddVerticalSpace(15),
            BlocBuilder<PicOfDayListBloc, PicOfDayListState>(
                builder: (context, state) {
              return TextField(
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.send,
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
                return PicOfDayList(
                  key: const Key('picOfDay_online_data'),
                  picOfDayList: state.picOfDayList,
                );
              } else if (state is PicOfDayListHasDataOffline) {
                return PicOfDayList(
                  key: const Key('picOfDay_offline_data'),
                  picOfDayList: state.picOfDayList,
                );
              } else if (state is PicOfDayListError) {
                return Center(
                  child: Text(state.errorMessage),
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

  Future<void> connectionCheck(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        context.read<PicOfDayListBloc>().add(const OnInitialState());
      } else {
        context.read<PicOfDayListBloc>().add(const OnInitialStateOffline());
      }
    } on SocketException catch (_) {
      context.read<PicOfDayListBloc>().add(const OnInitialStateOffline());
    }
  }
}
