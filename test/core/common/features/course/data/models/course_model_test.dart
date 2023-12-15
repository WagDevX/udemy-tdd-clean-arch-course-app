import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/common/features/course/data/models/course_model.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  final timeStampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 1234560000,
  };

  final date = DateTime.fromMicrosecondsSinceEpoch(timeStampData['_seconds']!)
      .add(Duration(milliseconds: timeStampData['_nanoseconds']!));

  final timeSamp = Timestamp.fromDate(date);

  final tCourseModel = CourseModel.empty();

  final tMap = jsonDecode(fixture('course.json')) as DataMap;
  tMap['createdAt'] = timeSamp;
  tMap['updatedAt'] = timeSamp;

  test('should be a subclass of [Course] entity', () {
    expect(tCourseModel, isA<Course>());
  });

  group('empty', () {
    test('should return a [CourseModel] with empty data', () {
      final result = CourseModel.empty();
      expect(result.title, '_empty.title');
    });
  });

  group('fromMap', () {
    test('should return a valid [CourseModel] from [DataMap]', () {
      final result = CourseModel.fromMap(tMap);
      expect(result, equals(tCourseModel));
    });
  });

  group('toMap', () {
    test('should return a [DataMap] from [CourseModel]', () {
      final result = tCourseModel.toMap()
        ..remove('createdAt')
        ..remove('updatedAt');
      expect(
        result,
        equals(
          tMap
            ..remove('createdAt')
            ..remove('updatedAt'),
        ),
      );
    });
  });

  group('copyWith', () {
    test('should return a copy of [CourseModel] with updated data', () {
      final result = tCourseModel.copyWith(
        id: 'id',
        title: 'title',
        description: 'description',
        groupId: 'groupId',
        numberOfExams: 1,
        numberOfMaterials: 1,
        numberOfVideos: 1,
        image: 'image',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      expect(result, isA<CourseModel>());
      expect(result.id, 'id');
      expect(result.title, 'title');
      expect(result.description, 'description');
      expect(result.groupId, 'groupId');
      expect(result.numberOfExams, 1);
      expect(result.numberOfMaterials, 1);
      expect(result.numberOfVideos, 1);
      expect(result.image, 'image');
      expect(result.createdAt, isA<DateTime>());
      expect(result.updatedAt, isA<DateTime>());
    });
  });
}
