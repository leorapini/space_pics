import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:space_pics/domain/entities/pic_of_day.dart';
import 'package:space_pics/domain/usecases/get_pictures.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockPicturesRepository mockPicturesRepository;
  late GetPictures usecase;

  setUp(() {
    mockPicturesRepository = MockPicturesRepository();
    usecase = GetPictures(repo: mockPicturesRepository);
  });

  const testPicture = PicOfDay(
    imgUrl: "https://apod.nasa.gov/apod/image/2208/CygnusWall_Bogaerts_960.jpg",
    title: "The Cygnus Wall of Star Formation",
    explanation:
        "The North America nebula on the sky can do what the North America continent on Earth cannot -- form stars.  Specifically, in analogy to the Earth-confined continent, the bright part that appears as Central America and Mexico is actually a hot bed of gas, dust, and newly formed stars known as the Cygnus Wall.  The featured image shows the star forming wall lit and eroded by bright young stars, and partly hidden by the dark dust they have created.  The part of the North America nebula (NGC 7000) shown spans about 15 light years and lies about 1,500 light years away toward the constellation of the Swan (Cygnus).",
    date: "2022-08-15",
  );

  final testListOfPictures = [testPicture];

  const testDate = "2022-08-15";

  test('Should return a list containing one picture from repository', () async {
    when(mockPicturesRepository.getPictures(
        startDate: testDate, endDate: testDate)).thenAnswer((_) async => testListOfPictures);

    final result =
        await usecase.execute(startDate: testDate, endDate: testDate);

    expect(result, equals(testListOfPictures));
  });
}
