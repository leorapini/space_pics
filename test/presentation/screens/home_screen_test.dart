import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_pics/data/constants/urls_and_paths.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_bloc.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_event.dart';
import 'package:space_pics/presentation/bloc/pic_of_day_list_state.dart';
import 'package:space_pics/presentation/screens/home/home_screen.dart';

import '../../helpers/sample_data.dart';

class MockPicOfDayListBloc
    extends MockBloc<PicOfDayListEvent, PicOfDayListState>
    implements PicOfDayListBloc {}

class FakePicOfDayListState extends Fake implements PicOfDayListState {}

class FakePicOfDayListEvent extends Fake implements PicOfDayListEvent {}

void main() {
  late MockPicOfDayListBloc mockPicOfDayListBloc;

  setUpAll(() async {
    registerFallbackValue(FakePicOfDayListEvent());
    registerFallbackValue(FakePicOfDayListState());

    final locator = GetIt.instance;
    locator.registerFactory(() => mockPicOfDayListBloc);
  });

  setUp(() {
    mockPicOfDayListBloc = MockPicOfDayListBloc();
  });

  const testPicOfDay = samplePicOfDay;
  const testPicOfDayList = [testPicOfDay];
  const testStartDate = sampleStartDate;

  Widget _makeTestWidget(Widget body) {
    return BlocProvider<PicOfDayListBloc>.value(
      value: mockPicOfDayListBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('textfield submition should change state form initial to loading',
      (WidgetTester tester) async {
    when(() => mockPicOfDayListBloc.state).thenReturn(PicOfDayListInitial());

    await tester.pumpWidget(_makeTestWidget(HomeScreen()));
    await tester.enterText(find.byType(TextField), testStartDate);
    await tester.testTextInput.receiveAction(TextInputAction.go);
    await tester.pumpAndSettle();

    verify(() =>
            mockPicOfDayListBloc.add(OnSearchSubmitted(value: testStartDate)))
        .called(1);
    expect(find.byType(TextField), equals(findsOneWidget));
  });

  testWidgets(
      'should show progress indicator when state is PicOfDayListLoading',
      (WidgetTester tester) async {
    when(() => mockPicOfDayListBloc.state).thenReturn(PicOfDayListLoading());

    await tester.pumpWidget(_makeTestWidget(HomeScreen()));

    expect(find.byType(CircularProgressIndicator), equals(findsOneWidget));
  });

  testWidgets(
    'should show widget that contains PicOfDay data when state is PicOfDayListHasData',
    (WidgetTester tester) async {
      when(() => mockPicOfDayListBloc.state)
          .thenReturn(PicOfDayListHasData(picOfDayList: testPicOfDayList));

      await tester.pumpWidget(_makeTestWidget(HomeScreen()));

      expect(find.byKey(Key('picOfDay_online_data')), equals(findsOneWidget));
    },
  );

  testWidgets(
    'should show widget that contains PicOfDay data when state is PicOfDayListHasDataOffline',
    (WidgetTester tester) async {
      when(() => mockPicOfDayListBloc.state)
          .thenReturn(PicOfDayListHasDataOffline(picOfDayList: testPicOfDayList));

      await tester.pumpWidget(_makeTestWidget(HomeScreen()));

      expect(find.byKey(Key('picOfDay_offline_data')), equals(findsOneWidget));
    },
  );
}
